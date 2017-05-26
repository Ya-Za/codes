import Tree from "./Tree";
import NodeTree from "./NodeTree"

main();

function main() {
    // let n = [...numbers()];
    let n = [...numbers(true)];
    console.log(n);
}

function* numbers(c) {
    if (c) {
        return [1, 2, 3];
    } else {
        for (let i = 0; i < 10; i++) {
            yield i;
        }
    }
}