import os

def count_asm_lines(directory):
    total_lines = 0
    for root, _, files in os.walk(directory):
        for file in files:
            if file.endswith('.asm'):
                file_path = os.path.join(root, file)
                with open(file_path, 'r') as f:
                    lines = f.readlines()
                    total_lines += len(lines)
    return total_lines

if __name__ == "__main__":
    directory = './'
    total_lines = count_asm_lines(directory)
    print(f"Total lines of code in .asm files: {total_lines}")