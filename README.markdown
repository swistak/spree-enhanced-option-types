# Enchanced Option Types

## Description

This extension enchances spree functionality when handling products with
numerous and complex variants.

Following enchancements are provided:

* Admin side:
  * Selecting order of option types for prototype with drag & drop
  * Optional "modifiers" for option values that can modify price of variant
  * Option to generate set of variants from prototype with option types.
    When option is selected during product creation, variants are created for
    each combination of option values (eg. Sizes: [S,M,L], Colors: [Red, Blue]
    will generate 6 variants), with prices calculated from sum of product base price
    and amount of option_value modifiers.
  * Option to regenerate variants when needed.
  * Option to calculate variant price when creating new variant based on product
    price and sum of modifiers from option values.
* Client side variant selection:
  * using x select boxes (1 for each option_type)
  * using x sets of radio boxes grouped in fieldsets (one fieldset for each option type)
  * using 2d table of radio boxes (only when there are only 2 option types!)
* Javascript helpers:
  * Instant updating of price based on variant selected using above methods
  * Instand updating of number of on_hand units
  * enabling/disabling options that don't have corresponding variant.
  * products.js override (edge spree only) for working with variant images

Some of the functionality might not work without javascript, but much work was put
to make JS as unintrusive as possible, so It should be fairly easy excercise
to make it completelly JS independent.

## Credits

Created by Marcin Raczkowski (marcin.raczkowski@gmail.com)

2d table was inspired by Stephanie Powell [post](
http://blog.endpoint.com/2009/12/rails-ecommerce-product-optioning-in.html)
You can(and should!) read it.

## Examples

![Radiobox sets](/swistak/spree-enchanced-option-types/raw/master/doc/sets.jpg)
![selects sets](/swistak/spree-enchanced-option-types/raw/master/doc/selects.jpg)
![table](/swistak/spree-enchanced-option-types/raw/master/doc/2d.jpg)

On first example you can see sets of radio boxes and modifiers in action,
also notable is separation of base price and current(variant) price, only second one is updatable.

Second one shows selects - it's much more compact then previous example,
 but doesn't instantly show all options.

Thrid shows the 2d table for variant choosing.

## Instalation

For git users:
<code>git submodule add git://github.com/swistak/spree-enchanced-option-types.git vendor/extensions/enchanced_option_types</code>

for others (or git users that don't like submodules):
<code>ruby script/extension install git://github.com/swistak/spree-enchanced-option-types.git</code>

## Customization

User interface change is limited only to _cart_form partial from original spree.
it was separated into several subfiles to make customization and embeding in custom layouts easier.

There are no inline styles (except for 2d table, that absolutelly requires
some wire frame styles to look sane), you can either use provided _cart_form
partial as a replacement for generic spree partial, or you can roll your own and
only include one of variant choosing partials.

There are some special css classes you might be interested in:
.price.update - price field that should be updated with new price value if variant changes.
span.

Source is extensivelly documented and I recomend reading it.

## Limitations

- currently there's no way to change order of option types AFTER product is created

## TODO

- gracefull handling non-js users.
- test under other browsers then FF

## License

Copyright (c) 2009, Marcin Raczkowski
All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice,
      this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright notice,
      this list of conditions and the following disclaimer in the documentation
      and/or other materials provided with the distribution.
    * Neither the name of the Marcin Raczkowski nor the names of its
      contributors may be used to endorse or promote products derived from this
      software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.