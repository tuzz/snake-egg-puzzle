### Snake Egg Puzzle

```sh
sentient --run snake-egg.json \
         --machine lingeling  \
         --assign-file example/assignments.json \
         | ruby pretty_print.rb
```

Sentient finds the solution from this [YouTube video](https://youtu.be/73Meh3NPno4)
in about two minutes:

```
9 9 █ █ █ 7 █ █ █ █
9 9 9 9 █ 7 █ 5 5 █
█ █ █ 9 █ 7 █ █ 5 █
2 2 █ 9 █ 7 7 █ 5 █
█ █ █ 9 █ 7 █ █ 5 █
█ 8 8 █ █ 7 █ 4 █ █
█ █ 8 █ 1 █ █ 4 █ 6
3 █ 8 █ █ █ 4 4 █ 6
3 █ 8 8 8 8 █ █ █ 6
3 █ █ █ █ █ █ 6 6 6
```
