import { Vector } from "../../src/Vector";
import { Shiny, CheckerBoard } from "../../src/Surface";

// todo: thinking about that if these are our expectations or not?
describe("Surface", () => {
    let pos1: Vector;
    let pos2: Vector;

    beforeAll(() => {
        pos1 = new Vector(0, 0, 0);
        pos2 = new Vector(0, 0, 1);
    });

    describe("Shiny", () => {
        it("reflect", () => {
            expect(Shiny.reflect(pos1))
                .toEqual(Shiny.reflect(pos2));

            expect(Shiny.reflect(pos1))
                .toBeGreaterThan(0.5);
        });

        it("diffuse", () => {
            expect(Shiny.diffuse(pos1))
                .toEqual(Shiny.diffuse(pos2));
        });

        it("specular", () => {
            expect(Shiny.specular(pos1))
                .toEqual(Shiny.specular(pos2));
        });

        it("roughness", () => {
            expect(Shiny.roughness)
                .toBeGreaterThan(200);
        });
    });

    describe("CheckerBoard", () => {
        it("reflect", () => {
            expect(CheckerBoard.reflect(pos1))
                .not.toEqual(CheckerBoard.reflect(pos2));
        });

        it("diffuse", () => {
            expect(CheckerBoard.diffuse(pos1))
                .not.toEqual(CheckerBoard.diffuse(pos2));
        });

        it("specular", () => {
            expect(CheckerBoard.specular(pos1))
                .toEqual(CheckerBoard.specular(pos2));
        });

        it("roughness", () => {
            expect(CheckerBoard.roughness)
                .toBeLessThan(200);
        });
    });
});
