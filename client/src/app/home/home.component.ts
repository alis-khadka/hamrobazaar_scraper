import { Component, OnInit } from '@angular/core';
import { Subject, of } from 'rxjs';
import { ProductsService } from '../products.service';
import {
  catchError,
  debounceTime,
  distinctUntilChanged,
  takeUntil
} from "rxjs/operators";

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss']
})
export class HomeComponent {

  flag = true
  text = '';
  data: any;
  error = '';
  _destroyed$: Subject<boolean> = new Subject<boolean>();
  _sellerSearchSub$: Subject<string> = new Subject<string>();

  constructor(public productsService: ProductsService) {
    this._sellerSearchSub$
      .pipe(
        debounceTime(3000),
        distinctUntilChanged(),
        takeUntil(this._destroyed$),
        catchError(err => {
          return of(err);
        })
      )
      .subscribe(data => {
        if (this.flag) {
          this.apiCall(data);
        }
      });
  }
  up(event) {
    console.log(event);
    this.flag = true;
    this._sellerSearchSub$.next(event);
  }

  apiCall(data) {
    if (data) {
      this.productsService
        .getData(data)
        .pipe(
          takeUntil(this._destroyed$),
          catchError(err => {
            return of(err);
          })
        )
        .subscribe(res => {
          if (res.success) {
            this.data = res.data;
            this.error = '';
          } else {
            this.data = '';
            this.error = res.error;
          }
          console.log(data);
        });
    }
  }

  searchProduct(event) {
    this.flag = false;
    this.apiCall(event);
  }



}
