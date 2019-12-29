build:
	mkdir -p dist
	elm make --optimize --output=dist/main.js src/Main.elm
