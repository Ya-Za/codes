/**
 * Linear Algebra
 */

/**
 * Dot product
 * @param u First vector
 * @param v Second vector
 */
export function dot(u: number[], v: number[]): number {
    let res = 0;

    let length = Math.min(u.length, v.length);
    for (let i = 0; i < length; i++) {
        res += u[i] * v[i];
    }

    return res;
}
