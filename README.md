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
* ceiling_entry Returns a key-value hash mapping associated with the least key greater than or equal to the given key, or nil if there is no such key.
* ceiling_key(key) Returns the least key greater than or equal to the given key, or nil if there is no such key.
* floor_entry(key) Returns a key-value hash mapping associated with the greatest key less than or equal to the given key, or nil if there is no such key.
* floor_key(key) Returns the greatest key less than or equal to the given key, or nil if there is no such key.
* entry_set Returns a Set view of the mappings contained in this map.

### How to use

* Clone this repo into your project root directory.
* require it

#### BST

```ruby
require_relative './lib/BST'

data = some_data_in_an_array

tree = BST.new()

# populate the tree
data.each_with_index do |key, idx|
  BST.put(key, idx)
end
```

#### LLBBST

```ruby
require_relative './lib/LLBBST'

data = some_data_in_an_array

tree = LLBBST.new()

# populate the tree
data.each_with_index do |key, idx|
  LLBBST.put(key, idx)
end
```
