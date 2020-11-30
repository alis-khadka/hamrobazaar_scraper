import { Component, OnInit } from '@angular/core';
import { ProductsService } from '../products.service';
import { Subject, of } from 'rxjs';
import {
  catchError,
  takeUntil
} from "rxjs/operators";

@Component({
  selector: 'app-products',
  templateUrl: './products.component.html',
  styleUrls: ['./products.component.scss']
})
export class ProductsComponent implements OnInit {

  data: any;
  error = '';
  _destroyed$: Subject<boolean> = new Subject<boolean>();

  constructor(public productsService: ProductsService) { }

  ngOnInit(): void {
    this.apiCall()
  }

  apiCall() {
    this.productsService
      .getAllData()
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
        console.log(res.data);
      });
  }

}
