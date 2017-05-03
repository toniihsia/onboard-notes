# How does a page get rendered?
1. Hits the router.
2. Router calls pageLoad.
3. Instantiates a class View.
4. Renders that View.
5. Destroys that View and rerun steps for new Page.

```
olympus.newClass('View.Base')
.done((newClass) => {
  var view = newClass.render()
  })
  ```
# Views
- Page is a constant, only destroy the instantiated View from inside of it.
- `this.ui` is a hash of DOM elements.
```
this.ui = {
  nameOfElement: [data-js~=name_of_attribute],
  nameOfElement: [data-js~=name_of_attribute]
}
```
- `this.events` is a hash of events to listen to.
```
this.events = {
  'typeOfEvent @element': 'fn',
  'typeOfEvent [name-of-data-js]': 'fn'
}
```

# Style Guide
### CSS
- Mixins are included at the bottom of normal attributes (before selectors)
**Do these**
```
  <div>

    <label />
    <label />
    <label />

    <div>
      <p></p>
      <p></p>
      <p></p>
    </div>

  </div>
```

```
  <div>
    <label />
    <label />
    <label />
  </div>
```

```
  .class {
    attribute: attr;
    attribute: attr;
    attribute: attr;
    @include mixin;

    .another-class {
      attribute: attr;
      attribute: attr;
      attribute: attr;
      @include mixin;
    }

    @include responsive('screen-size') {
      attribute: attr;
      attribute: attr;
      @include mixin;
    }
  }
```
![Notes from May 3](http://url/to/img.png)

#### Pipe Selectors

#### Sass
