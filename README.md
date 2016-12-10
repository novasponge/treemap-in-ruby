## BST and Left Leaning Red Black BST in Ruby

### Binary Search Tree (BST)

* Provides O(log(n)) runtime complexity for put, get, and delete in average cases and O(n) in worst case.  

#### Features

* put(key, val) Inserts a key with value.
* get_key(key) Returns the key or nil if there is no such key.
* get_val(key) Returns the value or nil if there is no such key.
* del(key) Deletes a key.

### Left Leaning Red Black BST (LLBBST)

* Guaranteed O(log(n)) runtime complexity for put, get and delete in all cases by dynamically balancing BST.
* LLBBST treemap is still under early development.
* New features will be continuously added in order to support basic treemap functionality.

#### Features

* put(key, val) Inserts a key with value.
* get_key(key) Returns the key or nil if there is no such key.
* get_val(key) Returns the value or nil if there is no such key.
* del(key) Deletes a key.
* del_min() Deletes min key.
* del_max() Deletes max key.
* min() Returns the min key.
* max() Returns the max key.
* higher_key(key) Returns the least key strictly greater than the given key, or nil if there is no such key.
* lower_key(key) Returns the greatest key strictly less than the given key, or nil if there is no such key.

### How to use

* Clone this repo into your project root directory.
* require it

#### BST

```ruby
require_relative 'BST'

data = some_data_in_an_array

tree = BST.new(data[0], true)

data.each do |entry|
  BST.put(entry)
end
```

#### LLBBST

```ruby
require_relative 'LLBBST'

data = some_data_in_an_array

tree = LLBBST.new(data[0], true)

data.each do |entry|
  LLBBST.put(entry)
end
```
