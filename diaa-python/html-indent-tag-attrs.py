import vim


def IndentHTMLTagAttrs():
    buf = vim.current.buffer
    buf = vim.current.buffer
    line_number = vim.current.window.cursor[ 0 ]
    line = buf[line_number - 1]
    splits = line.split('" ')
    # Find spaces in the line begining
    spaces = int(sum(1 for c in splits[0] if c == ' '))
    new_lines = [ l + '"\n' for l in splits]
    # Merge last split with the one before it, if it has no "
    if '"' not in new_lines[-1]:
        new_lines[-2] = new_lines[-2] + new_lines[-1]
    space = ''.join([' ' for i in range(0, spaces)])
    change = [new_lines[0]]
    for line in new_lines[1:]:
        change.append(space + line)
    change[-1] = change[-1][:-2] + '\n'
    if '"' not in change[-1]:
        change[-1] = change[-1].replace(' ', '')
        change[-2] = change[-2] + change[-1]
        change[-2] = change[-2].replace('\n', '')
        del change[-1]
    buf[:] = buf[:line_number - 1] + change + buf[line_number:]
