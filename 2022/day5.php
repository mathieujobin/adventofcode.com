<?php

$input = file_get_contents('day5-input.txt');
[$drawing, $instructions] = explode("\n\n", $input);

$cubes = [];
$stacks_p1 = [];

foreach (explode("\n", $drawing) as $l) {
    $cubes[] = str_split($l, 4);
}
array_pop($cubes);
$cubes = array_reverse($cubes);

foreach ($cubes as $cube) {
    foreach ($cube as $stack => $box) {
        if ($box = trim($box)) {
            $stacks_p1[$stack][] = $box[1];
        }
    }
}

$stacks_p2 = $stacks_p1;

foreach (explode("\n", $instructions) as $instruction) {
    $tok = explode(' ', $instruction);
    // Part 1
    for ($i = 0; $i < $tok[1]; $i++) {
        array_push($stacks_p1[$tok[5]-1], array_pop($stacks_p1[$tok[3]-1]));
    }
    // Part 2
    //$move = array_splice($stacks_p2[$tok[3]-1], -$tok[1], $tok[1]);
    //$stacks_p2[$tok[5]-1] = array_merge($stacks_p2[$tok[5]-1], $move);
}

$out = fn($s, $i) => $s .= end($i);
$p1 = array_reduce($stacks_p1, $out, '');
//$p2 = array_reduce($stacks_p2, $out, '');

echo "Solutions:\n* Part 1: $p1\n* Part 2: $p2\n";
