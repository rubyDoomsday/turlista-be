# Turlista-BE

![Build](https://github.com/rubyDoomsday/turlista-be/workflows/Build/badge.svg?branch=master&event=status)

_It means 'timetable' in swedish_

Turlista is a group trip planner that simplifies the process of organizing itineraries and tracking
expensess for you and your friends.

## Documentation

### API Docs

This project leverages [swagger-blocks](https://github.com/fotinakis/swagger-blocks/) for public
facing API information.

### View Code Documentation

This project conforms to [yard](https://github.com/lsegal/yard) for code documentation. To view code
docs run:

```
   script/docs
```

### Project Documentation

For high level design, ADRs, and additional documentation, browse the [wiki](./wiki).

## Dependencies

| Type     | Dependency |
| -------- | ---------- |
| database | Postgres   |

### Environment Variables

| name      | default        | definition           |
| --------- | -------------- | -------------------- |
| DB_HOST   | localhost      | the host for the DB  |
| DB_PORT   | 5432           | The port for the DB  |
| DB_USER   | postgres       | The DB user name     |
| DB_PASS   | password       | The DB user password |
| BASE_PATH | localhost:3000 | The App URL          |

## Installing

This project makes a best effort to conform to the
[scripts-to-rule-them-all](https://github.com/github/scripts-to-rule-them-all) best practices.
The following command should get your development environment up and running in no time.

### Mac OS

```
  script/bootstrap # get dependencies
  script/setup # creates a "clean slate" state
```

## Running

This project has been designed to function as a stand-alone API and can be used as such or in
conjunction with a separate front-end application.

### Locally

```
  bundle exec rails s
```

## Testing

### Locally

This project leverages the [parallelel_tests](https://github.com/grosser/parallel_tests) gem to
expedite local test suite execution. Tests may be run from the command line using the provided
script.

```
  script/test
```

## Contributing

## License

<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons
License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a><br
/><span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text"
property="dct:title" rel="dct:type">Turlista</span> by <a xmlns:cc="http://creativecommons.org/ns#"
href="https://github.com/rubyDoomsday/turlista-be" property="cc:attributionName"
rel="cc:attributionURL">Rebcca Chapin</a> is licensed under a <a rel="license"
href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0
International License</a>.<br />Based on a work at <a xmlns:dct="http://purl.org/dc/terms/"
href="https://github.com/rubyDoomsday/turlista-be"
rel="dct:source">https://github.com/rubyDoomsday/turlista-be</a>
