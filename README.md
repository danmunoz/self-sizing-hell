# Self Sizing Cells
Exploratory sample project used to determine how to better implement self-sizing cells.
## Introduction
In order to explore better ways to implement self sizing cells  beyond the most basic cases (standalone table or collection view) we decided to create examples of a `UICollectionView` inside a `UITableView`. 

### 1. Square View
The first example contains a fixed size **square view** as the sole object inside the `UICollectionViewCell`.

In a very general level, the objective is to create something like this:

* UIViewController
	* UITableView
		* UITableViewCell
			*  Square view
		* UITableViewCell ...
		* UITableViewCell ...



