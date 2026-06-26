[![Download JAR](https://img.shields.io/badge/Download-JAR%20(latest%20release)-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)](https://github.com/Kycks912004/projet-java-ing3/releases/latest)
[![Code Source](https://img.shields.io/badge/Java-Voir%20le%20code%20source-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)](https://github.com/Kycks912004/projet-java-ing3/tree/main/projet-java-ing3-2025-ing3-java-2025-11-2-main/src)
[![Build](https://github.com/Kycks912004/projet-java-ing3/actions/workflows/build-release.yml/badge.svg)](https://github.com/Kycks912004/projet-java-ing3/actions/workflows/build-release.yml)

# 🏨 Booking Application — Java OOP

Application de réservation d'hébergements avec interface graphique Swing, base de données embarquée SQLite, et statistiques JFreeChart.

## 🖼️ Architecture du Projet

<div align="center">

**Diagramme de classes complet (UML)**

![Diagramme de classes](https://raw.githubusercontent.com/Kycks912004/projet-java-ing3/main/projet-java-ing3-2025-ing3-java-2025-11-2-main/docs/diagramme_classe_complet.png)

**Vue simplifiée**

![Diagramme simplifié](https://raw.githubusercontent.com/Kycks912004/projet-java-ing3/main/projet-java-ing3-2025-ing3-java-2025-11-2-main/docs/diagramme_classe_sans_m%C3%A9thodes.png)

</div>

---

## 🚀 Lancer l'application (aucune installation requise)

1. **Télécharger** le JAR depuis [la dernière Release](https://github.com/Kycks912004/projet-java-ing3/releases/latest)
2. **Java 8+** doit être installé ([télécharger ici](https://adoptium.net/))
3. **Double-cliquer** sur le JAR, ou lancer en terminal :
   ```bash
   java -jar booking-app-1.0-SNAPSHOT-jar-with-dependencies.jar
   ```

> La base de données SQLite (`booking.db`) est **créée automatiquement** au premier lancement dans le même dossier que le JAR — aucun serveur, aucun compte requis.

### Identifiants de démonstration

| Rôle | Identifiant | Mot de passe |
|------|-------------|--------------|
| Admin | `admin` | `admin123` |
| Utilisateur | `john_doe` | `password123` |

---

## ✨ Fonctionnalités

- **Authentification** et inscription avec validation
- **Recherche** d'hébergements (ville, type, prix, équipements)
- **Réservations** avec calcul automatique du prix
- **Codes promo** et gestion des promotions
- **Historique** des réservations et annulation
- **Avis et notes** (système d'étoiles 1–5)
- **Dashboard admin** avec statistiques JFreeChart
- **Paiement simulé** (carte bancaire / virement)

---

## 🛠️ Stack Technique

| Composant | Technologie |
|-----------|-------------|
| Langage | Java 8 |
| Interface graphique | Swing (MVC) |
| Base de données | **SQLite** (embarquée) · MySQL compatible |
| Connexion BDD | JDBC |
| Graphiques | JFreeChart |
| Build | Maven |
| CI/CD | GitHub Actions |

---

## 🗂️ Architecture MVC

```
src/main/java/com/booking/
├── model/          ← Entités (User, Accommodation, Booking…)
├── view/           ← Composants Swing (fenêtres, panels)
├── controller/     ← Logique métier
├── dao/            ← Accès base de données (JDBC)
└── utils/          ← DatabaseConnection, helpers
```

**Tables :** `users` · `accommodations` · `bookings` · `payments` · `reviews` · `promotions` · `amenities`

---

## 🔌 Connexion à une BDD externe (optionnel)

Par défaut l'app utilise SQLite embarqué. Pour utiliser MySQL :

1. Créer un fichier `db.properties` dans le même dossier que le JAR :
   ```properties
   db.url=jdbc:mysql://HOST:3306/booking_db?useSSL=false&serverTimezone=UTC
   db.user=root
   db.password=VOTRE_MDP
   ```
2. Relancer le JAR — il détecte automatiquement le fichier.

---

## Author

**Kylian Pinto** — M1 Ingénierie Data & IA, ECE Paris  
[![GitHub](https://img.shields.io/badge/GitHub-Kycks912004-181717?style=flat&logo=github)](https://github.com/Kycks912004)
