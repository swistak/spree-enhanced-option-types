= Enchanced Option Types

This extension allows for creating enchanced option values that add modifiers to master price of product.
When you create new product from from prototype you get option to create variants. 
Variants will be created for each combination of option values, and price for each variant will be set by suming all modifiers and master price of product.
You can also create variants by hand, or create all of them then remove ones with combinations of option values you don't want.

User won't be able to select combination that doesn't have corresponding variant, enabling/disabling is done in real time.

== Limitations

- currently there's no way to change order of option types AFTER product is created

== TODO

- gracefull handling non-js users.
- test under other browsers then FF
