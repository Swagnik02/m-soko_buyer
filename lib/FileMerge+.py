import os
import datetime

def get_directory_tree(directory, ignore_patterns):
    tree = ''
    for root, dirs, files in os.walk(directory):
        # Exclude specific folders from the tree
        dirs[:] = [d for d in dirs if d not in ['.git', 'node_modules']]

        level = root.replace(directory, '').count(os.sep)
        indent = ' ' * 4 * level
        tree += f"{indent}- {os.path.basename(root)}/\n"
        sub_indent = ' ' * 4 * (level + 1)
        for file in files:
            # Check if file matches any ignore pattern
            file_path = os.path.join(root, file)
            if is_ignored(file_path, ignore_patterns):
                continue  # Skip the file
            tree += f"{sub_indent}- {file}\n"
    return tree

def load_ignore_patterns(directory):
    ignore_file = os.path.join(directory, '.fileignore')
    ignore_patterns = []
    if os.path.exists(ignore_file):
        with open(ignore_file, 'r') as f:
            ignore_patterns = f.read().splitlines()
    return ignore_patterns

def is_ignored(file_path, ignore_patterns):
    file_name = os.path.basename(file_path)
    for pattern in ignore_patterns:
        if pattern.endswith('/'):
            if file_path.startswith(os.path.join(pattern.rstrip('/'), '')):
                return True
        else:
            if pattern.lower() == file_name.lower():
                return True
    return False

def merge_files(directory, output_file):
    # Load ignore patterns from .fileignore
    ignore_patterns = load_ignore_patterns(directory)

    # Default ignore patterns
    default_ignore_patterns = ['.fileignore', 'FileMerge+.py', 'merged.txt', 'FileMerge+.exe','.gitignore','.dockerignore']
    executable_extensions = ['.exe', '.bat', '.sh','.json','.ico','.png','.svg']
    default_ignore_patterns.extend(executable_extensions)
    ignore_patterns.extend(default_ignore_patterns)

    # Get the formatted directory tree
    directory_tree = get_directory_tree(directory, ignore_patterns)

    with open(output_file, 'w', encoding='utf-8') as output:
        # Get the current date
        current_date = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")

        # Write the date at the top
        output.write(f"Date: {current_date}\n\n")

        # Write the file details after the date
        output.write(f"Root File Path: {os.path.abspath(directory)}\n")
        output.write("Directory Tree:\n")
        output.write(directory_tree)
        output.write("\n\n")

        for root, _, filenames in os.walk(directory):
            for filename in filenames:
                filepath = os.path.join(root, filename)
                if is_ignored(filepath, ignore_patterns):
                    continue
                if any(folder in filepath for folder in ['.git', 'node_modules']):
                    continue

                with open(filepath, 'r', encoding='utf-8', errors='ignore') as file:
                    # Write the directory tree before the file name
                    directory_tree = os.path.relpath(root, directory)
                    output.write(f'--- {directory_tree}/{filename} ---\n')
                    file_contents = file.read()
                    output.write(file_contents)
                    output.write('\n\n')

# Get the directory of the currently executing script
script_directory = os.path.dirname(os.path.abspath(__file__))

# Specify the output file path within the script directory as "merged.txt"
output_file_path = os.path.join(script_directory, 'merged.txt')

# Call the function to merge the files within the current directory
merge_files(script_directory, output_file_path)