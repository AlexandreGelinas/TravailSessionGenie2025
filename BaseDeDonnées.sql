-- Alexandre Gélinas, Simon Pratte et Olivier Nadeau
-- 2 Avril 2025
-- Base de données pour le projet


-- Tables

-- Les informations de l'utilisateur

CREATE TABLE Utilisateur (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL CHECK (email LIKE '%@cegeptr.qc.ca'),
    mot_de_passe VARCHAR(255) NOT NULL,
    photo_profil TEXT, -- Optionnel ?
    age INT,
    sexe VARCHAR(10),
    biograpghie VARCHAR(200), 
    programme VARCHAR(100),
    statut VARCHAR(20) CHECK (statut IN ('Étudiant', 'Employé')),
    langues TEXT,
    loisirs TEXT,
    disponibilites TEXT,
    date_inscription TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Le 'match' entre deux utilisateurs.

CREATE TABLE Match (
    id SERIAL PRIMARY KEY,
    utilisateur1_id INT REFERENCES Utilisateur(id) ON DELETE CASCADE,
    utilisateur2_id INT REFERENCES Utilisateur(id) ON DELETE CASCADE,
    date_match TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(utilisateur1_id, utilisateur2_id)
);