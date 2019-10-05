import { Component, OnInit, AfterViewInit } from '@angular/core';
import * as $ from 'jquery';

@Component({
    selector: 'app-landing',
    templateUrl: './landing.component.html',
    styleUrls: ['./landing.component.scss']
})

export class LandingComponent implements OnInit {
  focus: any;
  focus1: any;

  constructor() { }

  ngOnInit() {
    $("nav").show();
    $("footer").show();
    // $('.navbar').show();
    // $('.footer').show();
    // $('.navbar-collapse').show();
  }

  ngAfterViewInit(){
    
  }

}
