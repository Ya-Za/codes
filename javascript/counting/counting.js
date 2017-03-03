class Counting {
    static print(iterator) {
        while (true) {
            let item = iterator.next()
            
            if (item.done) {
                break
            }

            console.log(item.value)
        }
    }

    static *range(n) {
        var i = 0
        while (i < n) {
            yield i
            i += 1
        }
    }

    static *production_rule(arr) {
        /* PRODCUTION_RULE implements `cartesian product`
        * 
        * Examples
        * --------
        * 1. 
        *   >>> Counting.print(Counting.prodcution_rule([2, 3]))
        *   >>> [[1, 1], [1, 2], [1, 3], [2, 1], [2, 2], [2, 3]]
        */
        var state = Array(arr.length).fill(0)
        yield Array.from(state)
        
        var index = arr.length - 1
        while (index > -1) {
            state[index] += 1
            if (state[index] < arr[index]) {
                for (index = index + 1; index < arr.length; index++) {
                    state[index] = 0
                }
                yield Array.from(state)
                index -= 1
            } else {
                index -= 1
            }
        }
    }

    static *production_rule2(arr) {
        /* PRODCUTION_RULE2 implements `cartesian product`
        * 
        * Examples
        * --------
        * 1. 
        *   >>> Counting.print(Counting.prodcution_rule([2, 3]))
        *   >>> [[1, 1], [1, 2], [1, 3], [2, 1], [2, 2], [2, 3]]
        */
        
        var max_level = arr.length
        var state = Array(max_level).fill(0)

        var recursive_prodcution_rule = function* (index) {
            if (index == max_level) {
                yield Array.from(state)
            } else {
                for (let value = 0; value < arr[index]; value++) {
                    state[index] = value
                    yield* recursive_prodcution_rule(index + 1)
                }
            }
        }

        yield* recursive_prodcution_rule(0)

    }
}