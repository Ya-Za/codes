main();

function main() {
    // range
    // let rangeObj = range(10);
    // while (true) {
    //     let x = rangeObj.next();
    //     if (x.done) {
    //         break;
    //     }

    //     console.log(x.value);
    // }

    // range2
    // for (let x of range2(10)) {
    //     console.log(x);
    // }

    // range3
    // for (let x of range3(10)) {
    //     console.log(x);
    // }

    var myIterable = {};
    myIterable[Symbol.iterator] = function* () {
        yield 1;
        yield 2;
        yield 3;
    };

    for (let value of myIterable) {
        console.log(value);
    }
}

interface VD {
    value: any,
    done: boolean
}

function range(stop: number) {
    let x = 0;

    return {
        next(): VD {
            if (x < stop) {
                let value = x;
                x += 1;
                return {
                    value: value,
                    done: false
                }
            } else {
                return {
                    value: undefined,
                    done: true
                }
            }
        }
    }
}

function* range2(stop: number) {
    for (let x = 0; x < stop; x++) {
        yield x;
    }
}

function range3(stop: number) {
    let obj = {};
    obj[Symbol.iterator] = function* () {
        for (let x = 0; x < stop; x++) {
            yield x;
        }
    }

    return obj;
}