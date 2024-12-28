import sys

with open("Makefile", "r") as file:
    START = False
    END = False
    for line in file:
        # print("NOT", line)
        # print(line.strip(), START, END)

        if START and line.strip().endswith(":"):
            END = True
        if START and not END:
            print(line.strip())
        if line.startswith(sys.argv[1]) and not END:
            line = " \n**  " + line.replace(":", "").strip() + "  **"
            START = True
            print(line)
            print("-----------")


for _ in range(100):
    print()
