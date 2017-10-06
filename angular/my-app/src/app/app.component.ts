import { Component } from '@angular/core';
import { Person } from './person';

@Component({
  selector: 'app-root',
  // template: '{{junk()}}',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title: string;
  todo: string[];
  people: Person[];
  color: string;

  constructor() {
    this.title = 'Yasin';
    this.todo = [
      'One',
      'Two',
      'Three'
    ];
    this.people = [
      new Person('Yasin', 10),
      new Person('Hassan', 12),
      new Person('Hamed', 18)
    ];
    this.color = 'red';
  }
  junk(): HTMLElement {
    const h1 = document.createElement('h1');
    const txt = document.createTextNode('Hello, Yasin!');

    h1.appendChild(txt);

    return h1;
  }
  onClick(item: string, job: HTMLElement): void {
    this.title = item;
    job.style.backgroundColor = '#FECE4E';
  }
  addJob(job: string) {
    if (job === '') {
      return;
    }

    this.todo.push(job);
  }
  getMessage(): string {
    return `Hello, ${this.title}`;
  }
}
