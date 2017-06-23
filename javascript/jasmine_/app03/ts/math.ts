export function add(a: number, b: number): number {
    return a + b;
}

export function mul(a: number, b: number): number {
    return a * b;
}

export function neg(a: number): number {
    return mul(-1, a);
}

export function sub(a: number, b: number): number {
    return add(a, neg(b));
}

export function inv(a: number): number {
    return 1 / a;
}

export function div(a: number, b: number): number {
    return mul(a, inv(b));
}
