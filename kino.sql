CREATE TABLE film (
    film_id     INTEGER  PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    titel       TEXT     NOT NULL,
    laenge_min  INTEGER  NOT NULL CHECK (laenge_min > 0),
    fsk         INTEGER  NOT NULL CHECK (fsk IN (0, 6, 12, 16, 18))
);

CREATE TABLE vorstellung (
    vorstellung_id  INTEGER   PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    film_id         INTEGER   NOT NULL,
    beginn          TIMESTAMP NOT NULL,
    saal            TEXT      NOT NULL,
    FOREIGN KEY (film_id) REFERENCES film(film_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE reservierung (
    reservierung_id  INTEGER  PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    vorstellung_id   INTEGER  NOT NULL,
    sitzplatz        TEXT     NOT NULL,
    name_gast        TEXT     NOT NULL,
    FOREIGN KEY (vorstellung_id) REFERENCES vorstellung(vorstellung_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE (vorstellung_id, sitzplatz)
);

INSERT INTO film (titel, laenge_min, fsk) VALUES
    ('Metropolis', 153, 0), ('Das Boot', 149, 16), ('Lola rennt', 81, 12),
    ('Der Untergang', 156, 12), ('Goodbye Lenin!', 121, 6);

INSERT INTO vorstellung (film_id, beginn, saal) VALUES
    (1, '2026-07-01 20:00', 'Saal 1'), (2, '2026-07-01 18:00', 'Saal 2'),
    (3, '2026-07-02 21:00', 'Saal 1'), (4, '2026-07-02 19:30', 'Saal 3'),
    (5, '2026-07-03 17:00', 'Saal 2');

INSERT INTO reservierung (vorstellung_id, sitzplatz, name_gast) VALUES
    (1, 'A1', 'Mertens, Paul'), (1, 'A2', 'Mertens, Paul'),
    (1, 'B5', 'Fischer, Ruth'), (2, 'C3', 'Wagner, Erik'),
    (3, 'A1', 'Schulze, Lena'), (3, 'D7', 'Schulze, Lena'),
    (4, 'B2', 'Braun, Otto'), (5, 'A3', 'Klein, Marie');
