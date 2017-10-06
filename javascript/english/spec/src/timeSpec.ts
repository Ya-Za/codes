import { formal, informal } from "../../src/time";

describe("time", () => {
    let times: string[];

    beforeAll(() => {
        times = [
            "00:00",
            "06:00",
            "12:00",
            "18:00",
            "13:05",
            "13:10",
            "13:15",
            "13:30",
            "13:45",
            "13:50",
            "13:55"
        ];
    });

    it("formal - 24-hour", () => {
        // arrange
        const expected = [
            "zero o'clock",
            "six o'clock",
            "twelve o'clock",
            "eighteen o'clock",
            "thirteen [oh] five",
            "thirteen ten",
            "thirteen fifteen",
            "thirteen thirty",
            "thirteen forty-five",
            "thirteen fifty",
            "thirteen fifty-five"
        ];
        // act
        const actual = times.map(x => formal(x));
        // assert
        expect(actual).toEqual(expected);
    });
    it("formal - 12-hour", () => {
        // arrange
        const expected = [
            "twelve o'clock am",
            "six o'clock am",
            "twelve o'clock pm",
            "six o'clock pm",
            "one [oh] five pm",
            "one ten pm",
            "one fifteen pm",
            "one thirty pm",
            "one forty-five pm",
            "one fifty pm",
            "one fifty-five pm"
        ];
        // act
        const actual = times.map(x => formal(x, true));
        // assert
        expect(actual).toEqual(expected);
    });
    it("informal", () => {
        // arrange
        const expected = [
            "twelve o'clock at midnight",
            "six o'clock at sunrise/dawn",
            "twelve o'clock at midday/noon",
            "six o'clock at sunset/dusk",
            "five [minutes] past one in the afternoon",
            "ten [minutes] past one in the afternoon",
            "[a] quarter [minutes] past one in the afternoon",
            "half [minutes] past one in the afternoon",
            "[a] quarter [minutes] to two in the afternoon",
            "ten [minutes] to two in the afternoon",
            "five [minutes] to two in the afternoon"
        ];
        // act
        const actual = times.map(x => informal(x));
        // assert
        expect(actual).toEqual(expected);
    });
});