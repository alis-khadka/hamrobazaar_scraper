import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class ProductsService {

  constructor(
    private http: HttpClient
  ) { }

  getData(searchText){
    const url = 'http://localhost:3000/products/search?search=' + searchText;
    return this.http.get(url);
  }

  getAllData() {
    const url = 'http://localhost:3000/products';
    return this.http.get(url);
  }
}
