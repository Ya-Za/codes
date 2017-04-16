class A {
    a: string
    constructor(a: string) {
        this.a = a
    }
    print() {
        return this.a
    }
}

class B extends A {
    b: string
    constructor(a: string, b: string) {
        super(a)
        this.b = b
    }
}

class C extends B {
    c: string
    constructor(a: string, b: string, c: string) {
        super(a, b)
        this.c = c
    }
}