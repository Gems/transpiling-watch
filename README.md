# transpiling-watch
Bash utility daemon watched files changes and transpiling them.

## Motivation
It is common task to recompile code bundle on changes or transpile from one language to another. 

For example:
- JSX to JS 
- coffee script to JS
- flac to mp3, aac, etc
- png to webp, jpeg2000, jpeg xr
- less to css

and others.

## Usage

In order to use utility you have to markup your code structure and configure transpiling rules.

Run daemon by `/path/to/transpiling-watcher/watcher.sh /path/to/your/code`. Assumed that `/path/to/your/code` is path to your code repository you are wanted to watch.

Inside `/path/to/your/code` directory or inside it's subdirectories you have to create `.watch` files in order to define transpiling rules for files inside this directory or it's subdirectories. File changes inside directories without `.watch` file or it's ancestor directories will be ignored.

### `.watch` file format

Example:
```
flac: ffmpeg -i {} %w/%f.aac
less: node my-less-transpiler.js {} >%w/../../output/%f.css
jsx: /usr/local/bin/jsx-compiler.sh {} >%w/compiled/%f.js
```

In `.watch` file you define transpile rule one per line. Transpiling rule is just a shell command followed by file extension and `:` char as separator.

In order to supply transpiling script with content you can use `{}` construction that will be replaced with full path to changed file. Also you can use `%w` construction that will be replaced with directory path for changed file. `%f` construction for filename without extension and `%fe` for filename with extension.

__
HTH, enjoy :)
