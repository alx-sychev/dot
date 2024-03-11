config.load_autoconfig(False)
c.editor.command = ['st', '-e', 'nvim', '{file}', '-c', 'normal {line}G{column0}l']
c.zoom.default = 125
