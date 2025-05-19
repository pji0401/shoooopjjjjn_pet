import os
import graphviz
import statistics
from typing import Optional, List, Dict
import colorsys

def create_directory_graph(
    root_path: str, 
    target_extensions: List[str] = ['.py'],
    visualize_folders: bool = True
):
    '''디렉토리 구조 시각화용 Graphviz Digraph 객체 생성.

    지정된 루트 경로로부터 시작하여 디렉토리 및 파일 구조를 탐색하고,
    이를 Graphviz Digraph 객체로 변환하여 반환함.
    파일 크기 및 폴더 내 자식 노드 수에 따라 노드 색상을 다르게 표현 가능.

    Args:
        root_path (str): 시각화 대상 루트 디렉토리 경로.
        target_extensions (List[str], optional): 시각화에 포함할 특정 파일 확장자 목록.
            기본값은 `['.py']`.
        visualize_folders (bool, optional): 폴더 노드 색상을 자식 노드 수에 따라 동적으로
            결정할지 여부. `False`일 경우 모든 폴더는 기본색('skyblue')으로 표시됨.
            기본값은 `True`.

    Returns:
        graphviz.Digraph: 생성된 디렉토리 구조 그래프를 나타내는 Graphviz Digraph 객체.
    '''

    dot = graphviz.Digraph(comment='Directory Structure')
    dot.attr(rankdir='LR')
    
    def get_node_id(path: str) -> str:
        rel_path = os.path.relpath(path, root_path)
        return rel_path.replace('\\', '_').replace('/', '_')
    
    def get_human_readable_size(size_in_bytes: float) -> str:
        for unit in ['B', 'KB', 'MB', 'GB']:
            if size_in_bytes < 1024.0:
                return f"{size_in_bytes:.1f}{unit}"
            size_in_bytes /= 1024.0
        return f"{size_in_bytes:.1f}TB"
    
    def get_base_color(value: int) -> str:
        if value < 1024:  # 1KB 미만
            return '#E6F3FF'  # 연한 파랑
        elif value < 1024 * 10:  # 10KB 미만
            return '#B3D9FF'  # 중간 파랑
        else:
            return '#80BFFF'  # 진한 파랑
    
    def get_color_for_value(value: int, min_value: int, max_value: int) -> str:
        values = list(target_file_sizes.values())
        mean = statistics.mean(values)
        stdev = statistics.stdev(values) if len(values) > 1 else 0

        if stdev == 0:
            return get_base_color(value)

        z_score = (value - mean) / stdev
        normalized = (z_score + 2) / 4
        normalized = max(0, min(1, normalized))

        hue = (1 - normalized) * 120 / 360.0
        rgb = colorsys.hsv_to_rgb(hue, 0.8, 0.9)
        return '#{:02x}{:02x}{:02x}'.format(int(rgb[0]*255), int(rgb[1]*255), int(rgb[2]*255))
    
    target_file_sizes = {}
    folder_child_counts = {}
    
    def should_exclude(path: str) -> bool:
        excluded_patterns = [
            # 기존 Python 및 일반 제외 패턴
            'env',
            'venv',
            '.venv',
            'anaconda3',
            '__pycache__',
            '.git',
            '.pytest_cache',
            'node_modules',
            '.vscode',

            # Flutter 및 Dart 관련 제외 패턴
            '.dart_tool',
            '.flutter-plugins',
            '.flutter-plugins-dependencies',
            '.packages',
            '.pub-cache', # 전역 캐시일 수도 있지만, 로컬에 생성될 경우 대비
            'build',     # Flutter 빌드 출력 폴더 (Android, iOS, Web 등)
            'ios/.symlinks',
            'ios/Pods',
            'ios/Flutter/App.framework',
            'ios/Flutter/Flutter.framework',
            'ios/Flutter/Generated.xcconfig',
            'ios/Flutter/flutter_export_environment.sh',
            # 'ios/Runner.xcworkspace', # 폴더 자체보다는 내부의 user-specific 파일이 문제
            'ios/DerivedData',
            'android/.gradle',
            # 'android/app/build', # 'build' 패턴으로 커버 가능
            # 'android/build',     # 'build' 패턴으로 커버 가능
            'android/key.properties', # 민감 정보
            'windows/flutter/generated_plugins.cmake',
            'linux/flutter/generated_plugins.cmake',
            'macos/Flutter/ephemeral',
            'macos/Flutter/GeneratedPluginRegistrant.swift', # 생성 파일
            'web/build', # 'build' 패턴으로 커버 가능

            # IDE 및 편집기 파일 (추가)
            '*.iml', # IntelliJ / Android Studio
            '.idea', # IntelliJ / Android Studio (이미 .vscode와 유사한 역할)

            # OS 생성 파일 (추가)
            '.DS_Store', # macOS
            'Thumbs.db', # Windows
        ]
        path_parts = path.split(os.sep)
        return any(pattern in path_parts for pattern in excluded_patterns)
    
    def collect_stats(path: str):
        if should_exclude(path):
            return
            
        if os.path.isdir(path):
            try:
                direct_children = 0
                for item in os.listdir(path):
                    item_path = os.path.join(path, item)
                    if not should_exclude(item_path):
                        direct_children += 1
                        collect_stats(item_path)
                folder_child_counts[path] = direct_children
            except PermissionError:
                pass
        else:
            ext = os.path.splitext(path)[1].lower()
            if ext in target_extensions:
                target_file_sizes[path] = os.path.getsize(path)
    
    collect_stats(root_path)
    
    min_size = min(target_file_sizes.values()) if target_file_sizes else 0
    max_size = max(target_file_sizes.values()) if target_file_sizes else 0
    min_children = min(folder_child_counts.values()) if folder_child_counts else 0
    max_children = max(folder_child_counts.values()) if folder_child_counts else 0
    
    def process_directory(path: str):
        if should_exclude(path):
            return
            
        node_id = get_node_id(path)
        name = os.path.basename(path) or path
        
        if os.path.isdir(path):
            child_count = folder_child_counts.get(path, 0)
            if visualize_folders:
                color = get_color_for_value(child_count, min_children, max_children)
            else:
                color = 'skyblue'
            
            label = f"{name} ({child_count})"
            dot.node(node_id, label, shape='folder', style='filled', fillcolor=color)
            
            try:
                for item in sorted(os.listdir(path)):
                    item_path = os.path.join(path, item)
                    if not should_exclude(item_path):
                        child_id = get_node_id(item_path)
                        dot.edge(node_id, child_id)
                        process_directory(item_path)
            except PermissionError:
                pass
        else:
            file_size = os.path.getsize(path)
            readable_size = get_human_readable_size(file_size)
            ext = os.path.splitext(path)[1].lower()
            
            if ext in target_extensions:
                color = get_color_for_value(file_size, min_size, max_size)
            else:
                color = '#D3D3D3'
            
            label = f"{name} ({readable_size})"
            dot.node(node_id, label, shape='note', style='filled', fillcolor=color)
    
    process_directory(root_path)
    return dot

if __name__ == '__main__':
    project_root = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', '..'))
    graph = create_directory_graph(
        project_root + '/lib',
        target_extensions=['.dart'],
        visualize_folders=True
    )
    if graph:
        graph.render('.outputs/directory_structure', view=True, format='png')
