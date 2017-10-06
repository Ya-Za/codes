/**
 * @author Yasin Zamani <yasin.zamani@gmail.com>
 */


const TEEN = "teen";
const TY = "ty";
// names of small cardinal numbers (< 1000)
const SC: { [key: string]: string } = {
    "0": "zero",
    "1": "one",
    "2": "two",
    "3": "three",
    "4": "four",
    "5": "five",
    "6": "six",
    "7": "seven",
    "8": "eight",
    "9": "nine",
    "10": "ten",
    "11": "eleven",
    "12": "twelve",
    "13": "thir" + TEEN,
    "14": "four" + TEEN,
    "15": "fif" + TEEN, // note "f", not "v"
    "16": "six" + TEEN,
    "17": "seven" + TEEN,
    "18": "eigh" + TEEN, // only one "t"
    "19": "nine" + TEEN,
    "20": "twenty",
    "30": "thir" + TY,
    "40": "for" + TY, // no "u"
    "50": "fif" + TY, // note "f", not "v"
    "60": "six" + TY,
    "70": "seven" + TY,
    "80": "eigh" + TY, // only one "t"
    "90": "nine" + TY, // note the "e"
    "100": "hundred"
};
// names of small ordinal numbers (< 1000)
const TH = "th";
const TIETH = "tieth";
const SO: { [key: string]: string } = {
    "0": SC["0"] + TH,
    "1": "first",
    "2": "second",
    "3": "third",
    "4": SC["4"] + TH,
    "5": "fif" + TH,
    "6": SC["6"] + TH,
    "7": SC["7"] + TH,
    "8": "eigh" + TH, // only one "t"
    "9": "nin" + TH, // no "e"
    "10": SC["10"] + TH,
    "11": SC["11"] + TH,
    "12": "twelf" + TH, // note "f", not "v"
    "13": SC["13"] + TH,
    "14": SC["14"] + TH,
    "15": SC["15"] + TH,
    "16": SC["16"] + TH,
    "17": SC["17"] + TH,
    "18": SC["18"] + TH,
    "19": SC["19"] + TH,
    "20": "twen" + TIETH,
    "30": "thir" + TIETH,
    "40": "for" + TIETH,
    "50": "fif" + TIETH,
    "60": "six" + TIETH,
    "70": "seven" + TIETH,
    "80": "eigh" + TIETH,
    "90": "nine" + TIETH
};
// names of large numbers(> 1000)
const ILLION = "illion";
const L: { [key: number]: string } = {
    1: "thousand",
    2: "m" + ILLION,
    3: "b" + ILLION,
    4: "tr" + ILLION,
};

function two(num: string, ordinal = false): string {
    let SX = SC;
    if (ordinal) {
        SX = SO;
    }

    if (num in SX) {
        return SX[num];
    } else {
        return SC[num[0] + "0"] + "-" + SX[num[1]];
    }
}

function three(num: string, ordinal = false): string {
    if (num.length < 3) {
        return two(num, ordinal);
    }

    // xx is the first two digits
    let xx = num.slice(-2);
    xx = Number(xx).toString();

    let xxName = "";
    if (ordinal) {
        xxName = "th";
    }

    if (Number(xx) !== 0) {
        xxName = " [and] " + two(xx, ordinal);
    }

    return SC[num[0]] + " " + SC["100"] + xxName;
}

function positive(num: string, ordinal = false): string {
    // valid number of digits
    const n = 15;
    let prefix = "";
    if (num.length > n) {
        prefix = positive(num.slice(0, -(n - 3))) + " " + L[n / 3 - 1];
        num = num.slice(-(n - 3));
    }

    // name of parts (a part has maximum 3 digits).
    let names: string[] = [];
    // `th` suffix for ordinal numbers
    let suffixTh = "";
    // first three digits
    let xxx = num.slice(-3);
    xxx = Number(xxx).toString();
    if (Number(xxx) !== 0) {
        names.unshift(three(xxx, ordinal));
    } else {
        if (ordinal) {
            suffixTh = 'th';
        }
    }
    num = num.slice(0, -3);

    // other three digits. `i` is index of each part
    let i = 1;
    while (num.length > 0) {
        xxx = num.slice(-3);
        xxx = Number(xxx).toString();
        if (Number(xxx) !== 0) {
            names.unshift(three(xxx) + " " + L[i]);
        }

        num = num.slice(0, -3);
        i += 1;
    }

    if (prefix !== "") {
        names.unshift(prefix);
    }
    return names.join(", ") + suffixTh;
}

export function integer(num: string, ordinal = false): string {
    // zoro
    if (num === "0") {
        if (ordinal) {
            return SO[num];
        } else {
            return SC[num];
        }
    }
    // negative
    let minus = "";
    if (num[0] === "-") {
        minus = "minus ";
        num = num.substring(1);
    }
    // non-negative
    return minus + positive(num, ordinal);
}

/**
 * Fraction (rational numbers)
 * @param a Numerator
 * @param b Denominator
 * @return Name of fraction
 */
export function fraction(a: string, b: string): string {
    // numerator
    let aName = integer(a);
    // denominator
    let bName = "";
    if (b === "2") {
        bName = "half";
    } else {
        bName = integer(b, true);
    }
    // fraction
    return aName + " " + bName;
}

/**
 * Mixed number (mixed fraction)
 * @param a Non-zero integer (whole number)
 * @param b Numerator of fraction
 * @param c Denominator of fraction
 * @return Named of mixed number
 */
export function mixed(a: string, b: string, c: string): string {
    return integer(a) + " and " + fraction(b, c);
}

export function real(num: string, mix = false): string {
    // whole and fraction parts of the number
    let [a, b] = num.split(".");

    if (b !== undefined) {
        if (mix) {
            return mixed(a, b, "1" + "0".repeat(b.length));
        } else {
            let name = [integer(a), "point"];
            for (let x of b) {
                name.push(integer(x));
            }
            return name.join(" ");
        }
    } else {
        return integer(a);
    }
}
