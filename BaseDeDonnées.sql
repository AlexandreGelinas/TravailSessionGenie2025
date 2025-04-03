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

-- Possibilité de messagerie?

CREATE TABLE Message (
    id SERIAL PRIMARY KEY,
    expediteur_id INT REFERENCES Utilisateur(id) ON DELETE CASCADE,
    destinataire_id INT REFERENCES Utilisateur(id) ON DELETE CASCADE,
    contenu TEXT NOT NULL,
    date_envoi TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Pour tenir un historique? Comme sur messenger
);

-- ajouté l'interet?

CREATE TABLE Evenement (
    id SERIAL PRIMARY KEY,
    createur_id INT REFERENCES Utilisateur(id) ON DELETE CASCADE,
    titre VARCHAR(255) NOT NULL,
    detail TEXT, -- Description (est-ce que description est un mot reservé?)
    date_evenement TIMESTAMP NOT NULL,
    lieu VARCHAR(255),
    capacite INT, -- Si c'est dans une salle?
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Pas vraiment nécéssaire?
);

-- Permet à l'utilsateur de "s'inscrire"

CREATE TABLE Participation (
    id SERIAL PRIMARY KEY,
    utilisateur_id INT REFERENCES Utilisateur(id) ON DELETE CASCADE,
    evenement_id INT REFERENCES Evenement(id) ON DELETE CASCADE,
    date_inscription TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(utilisateur_id, evenement_id)
);

-- Permet à l'utilisateur d'évaluer l'app

CREATE TABLE Evaluation (
    id SERIAL PRIMARY KEY,
    evaluateur_id INT REFERENCES Utilisateur(id) ON DELETE CASCADE,
    evalue_id INT REFERENCES Utilisateur(id) ON DELETE CASCADE,
    commentaire TEXT,
    note INT CHECK (note BETWEEN 1 AND 5),
    date_evaluation TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Il manquerait une table pour les notifications (how the fuck qu'on va faire ca?)
-- Merci Chat :)

CREATE TABLE Notification (
    id SERIAL PRIMARY KEY,
    utilisateur_id INT REFERENCES Utilisateur(id) ON DELETE CASCADE,
    message TEXT NOT NULL,
    date_notification TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    est_lu BOOLEAN DEFAULT FALSE
);