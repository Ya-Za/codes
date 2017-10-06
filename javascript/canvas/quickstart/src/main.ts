import { MyCanvas } from './my-canvas';

const canvas = document.getElementById('canvas') as HTMLCanvasElement;
canvas.width = document.body.clientWidth;
canvas.height = document.body.clientHeight;  


const mc = new MyCanvas(canvas);

// mc.clear();
// mc.segment(100, 100, 500, 500);
// mc.circle(500, 500, 100);

// mc.gradient1();
// mc.gradient2();

// mc.text1();

// mc.shadow1();

// mc.pattern1();

// mc.line1();

// mc.path1();
// mc.path2();

// mc.transform1();

mc.pattern2();
