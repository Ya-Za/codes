import Tree from "./Tree";
import NodeTree from "./NodeTree"

main();

function main() {
    for (let v of numbers()) {
        console.log(v);
    }
}

function* one() {
    yield* two();
}

function* two() {
    yield 1;
}

function* numbers() {
    for (let i = 0; i < 10; i++) {
        yield i;
    }
}