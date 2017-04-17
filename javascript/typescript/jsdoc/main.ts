/**
 * This is a function
 * @param param1 This is a first parameter
 * @param param2 This is the second parameter
 * @param param3 This is the third parameter
 * @returns Returns a value
 */
function func(param1: boolean, param2: string, param3: number): string {
    let message = ""
    return ""
}


let a = func(null, null, null)

/**
 * 
 */
class A {
    /**
     * 
     */
    a: string
    /**
     * 
     * @param a 
     */
    constructor(a: string) {
        this.a = a
    }
    /**
     * 
     */
    toString() {
        return this.a
    }
}

/**
 * 
 */
class B extends A {
    b: string
    /**
     * 
     * @param a 
     * @param b 
     */
    constructor(a: string, b: string) {
        super(a)
        this.b = b
    }

    /**
     * 
     */
    toString() {
        return super.toString() + this.b
    }
}