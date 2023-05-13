
-- Method 1
Update products
set properties = '{
	"weight": 10,
    "height": 24,
    "dimentions": [1, 2, 3],
    "manufacturer": {
		"name": "sony"
    }
}'
where product_id = 1;


-- method 2
update products
set properties = JSON_OBJECT(
	"weight", 10,
    "height", 24,
    "dimensions", JSON_ARRAY(1, 2, 3),
    "manufacturer", JSON_OBJECT("name", "sony")
)
where product_id = 2;

-- Selecting JSON object data
-- Method 1
select product_id, 
	JSON_EXTRACT(properties, "$.weight") AS weight,
    JSON_EXTRACT(properties, "$.height") AS height,
    JSON_EXTRACT(properties, "$.dimensions[0]"),
    JSON_EXTRACT(properties, "$.manufacturer.name"
    )
from products;

-- Method 2
select product_id, properties -> "$.weight",
	properties -> "$.height",
    properties -> "$.dimensions[0]",
    properties ->> "$.manufacturer.name"
from products;

-- SELECT all products where manufacturer is sony
select product_id
from products
where properties ->> "$.manufacturer.name" = 'sony';







