import Tree from "./Tree";
import NodeTree from "./NodeTree"

main();

function main() {
    // let n = [...numbers()];
    let n = Array.from(numbers());
    console.log(n);
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