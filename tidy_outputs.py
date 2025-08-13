import json
import os
import sys


def main():
    # Step 0: Initialize the output file
    output_dir = "./IT_SR"
    output_file = "Jailbreaking_Text.json"  # consider .jsonl extension

    path = os.path.join(output_dir, output_file)

    # Step 1: Load the .json file into an array of dicts (one JSON object per line)
    data = []
    with open(path, "r", encoding="utf-8") as f:
        for line in f:
            line = line.strip()
            if line:
                data.append(json.loads(line))

    # Step 2: Change each dict's "No." value to the index of the line plus one
    for i, item in enumerate(data, start=1):
        item["No."] = i

    # Step 3: Write back as JSON Lines (one compact object per line)
    with open(path, "w", encoding="utf-8") as f:
        for item in data:
            f.write(json.dumps(item, separators=(",", ":"), ensure_ascii=False) + "\n")


if __name__ == "__main__":
    main()
