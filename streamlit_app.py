import streamlit as st
import pandas as pd
import plotly.express as px
import plotly.graph_objects as go
from pathlib import Path

st.set_page_config(
    page_title="Booking App — Demo",
    page_icon="🏨",
    layout="wide",
    initial_sidebar_state="expanded"
)

# ─── DATA ──────────────────────────────────────────────────────────────────────
IMG_DIR = Path("projet-java-ing3-2025-ing3-java-2025-11-2-main/src/main/resources/images")

ACCOMMODATIONS = [
    {"id":27, "name":"Luxury Hotel Paris",        "city":"Paris",      "country":"France",    "type":"hotel",     "price":350, "guests":4, "rating":4, "wifi":True,  "pool":True,  "parking":True,  "restaurant":True,  "ac":True,  "lat":48.8698, "lon":2.3048, "img":"hotel_paris_1.jpg",     "desc":"Hôtel 5 étoiles au coeur de Paris avec vue sur la Tour Eiffel."},
    {"id":28, "name":"Cozy Apartment Montmartre", "city":"Paris",      "country":"France",    "type":"apartment", "price":120, "guests":2, "rating":4, "wifi":True,  "pool":False, "parking":False, "restaurant":False, "ac":True,  "lat":48.8865, "lon":2.3380, "img":"apartment_paris_1.jpg", "desc":"Appartement charmant dans le quartier artistique de Montmartre."},
    {"id":32, "name":"Seaside Villa Amalfi",      "city":"Amalfi",     "country":"Italy",     "type":"villa",     "price":420, "guests":6, "rating":5, "wifi":True,  "pool":True,  "parking":True,  "restaurant":False, "ac":True,  "lat":40.6346, "lon":14.6026, "img":"villa_amalfi.jpg",      "desc":"Villa avec vue panoramique sur la mer et piscine privée."},
    {"id":33, "name":"Rustic Chalet Chamonix",    "city":"Chamonix",   "country":"France",    "type":"chalet",    "price":180, "guests":5, "rating":3, "wifi":True,  "pool":False, "parking":True,  "restaurant":False, "ac":True,  "lat":45.9237, "lon":6.8694,  "img":"chalet_chamonix.jpg",   "desc":"Chalet alpin traditionnel proche des remontées mécaniques."},
    {"id":34, "name":"City Apartment Tokyo",      "city":"Tokyo",      "country":"Japan",     "type":"apartment", "price":130, "guests":2, "rating":4, "wifi":True,  "pool":False, "parking":False, "restaurant":False, "ac":True,  "lat":35.6618, "lon":139.7038,"img":"apartment_tokyo.jpg",   "desc":"Appartement moderne au coeur de Shibuya, accès métro direct."},
    {"id":35, "name":"Eco Cottage Quebec",        "city":"Quebec",     "country":"Canada",    "type":"cottage",   "price":110, "guests":3, "rating":2, "wifi":False, "pool":False, "parking":True,  "restaurant":False, "ac":False, "lat":46.8139, "lon":-71.2080,"img":"cottage_quebec.jpg",     "desc":"Chalet écologique entouré de nature avec poêle à bois."},
    {"id":36, "name":"Boutique Hotel Lisbon",     "city":"Lisbon",     "country":"Portugal",  "type":"hotel",     "price":160, "guests":2, "rating":4, "wifi":True,  "pool":False, "parking":True,  "restaurant":True,  "ac":True,  "lat":38.7071, "lon":-9.1374, "img":"hotel_lisbon.jpg",      "desc":"Hôtel boutique proche de la Praça do Comércio avec vue sur le Tage."},
    {"id":37, "name":"Beachfront Bungalow Bali",  "city":"Canggu",     "country":"Indonesia", "type":"cottage",   "price": 95, "guests":2, "rating":3, "wifi":True,  "pool":True,  "parking":False, "restaurant":False, "ac":False, "lat":-8.6478, "lon":115.1385,"img":"bungalow_bali.jpg",     "desc":"Bungalow à deux pas de la plage avec jardin tropical."},
    {"id":38, "name":"Historic Hotel Vienna",     "city":"Vienna",     "country":"Austria",   "type":"hotel",     "price":275, "guests":3, "rating":5, "wifi":True,  "pool":False, "parking":True,  "restaurant":True,  "ac":True,  "lat":48.2027, "lon":16.3688, "img":"hotel_vienna.jpg",      "desc":"Hôtel historique près de l'Opéra de Vienne."},
    {"id":39, "name":"Lakeview Cabin Tahoe",      "city":"Lake Tahoe", "country":"USA",       "type":"cabin",     "price":140, "guests":4, "rating":1, "wifi":True,  "pool":False, "parking":True,  "restaurant":False, "ac":True,  "lat":39.0968, "lon":-120.0324,"img":"cabin_tahoe.jpg",       "desc":"Cabane rustique avec vue sur le lac et randonnées à proximité."},
    {"id":40, "name":"Contemporary Condo Sydney", "city":"Sydney",     "country":"Australia", "type":"condo",     "price":220, "guests":2, "rating":2, "wifi":True,  "pool":False, "parking":True,  "restaurant":False, "ac":True,  "lat":-33.871, "lon":151.1966,"img":"condo_sydney.jpg",      "desc":"Condo moderne avec vue sur le port, idéal pour les explorateurs urbains."},
    {"id":41, "name":"Countryside Cottage Cotswolds","city":"Cotswolds","country":"UK",       "type":"cottage",   "price":150, "guests":4, "rating":3, "wifi":True,  "pool":False, "parking":True,  "restaurant":False, "ac":False, "lat":51.885,  "lon":-1.7580, "img":"cottage_cotswolds.jpg",  "desc":"Cottage en pierre dans la campagne anglaise, parfait pour se ressourcer."},
]

BOOKINGS = [
    {"id":10, "user":"john_doe",      "accommodation":"Luxury Hotel Paris",        "check_in":"2025-04-17","check_out":"2025-04-19","guests":2,"total":1400,"status":"CANCELLED"},
    {"id":11, "user":"john_doe",      "accommodation":"Cozy Apartment Montmartre", "check_in":"2025-04-18","check_out":"2025-04-20","guests":2,"total":480, "status":"CONFIRMED"},
    {"id":12, "user":"john_doe",      "accommodation":"Luxury Hotel Paris",        "check_in":"2025-05-01","check_out":"2025-05-05","guests":2,"total":1400,"status":"CONFIRMED"},
    {"id":13, "user":"jane_smith",    "accommodation":"Cozy Apartment Montmartre", "check_in":"2025-06-10","check_out":"2025-06-15","guests":4,"total":480, "status":"CONFIRMED"},
    {"id":17, "user":"diana_evans",   "accommodation":"Seaside Villa Amalfi",      "check_in":"2025-10-01","check_out":"2025-10-05","guests":6,"total":1500,"status":"CONFIRMED"},
    {"id":18, "user":"jane_smith",    "accommodation":"City Apartment Tokyo",      "check_in":"2025-12-01","check_out":"2025-12-05","guests":4,"total":720, "status":"CONFIRMED"},
    {"id":19, "user":"alice_johnson", "accommodation":"Eco Cottage Quebec",        "check_in":"2026-01-10","check_out":"2026-01-15","guests":3,"total":900, "status":"CONFIRMED"},
    {"id":20, "user":"bob_brown",     "accommodation":"Boutique Hotel Lisbon",     "check_in":"2026-02-01","check_out":"2026-02-05","guests":2,"total":600, "status":"CONFIRMED"},
    {"id":21, "user":"charlie_davis", "accommodation":"Beachfront Bungalow Bali",  "check_in":"2026-03-10","check_out":"2026-03-15","guests":5,"total":1500,"status":"CONFIRMED"},
    {"id":22, "user":"diana_evans",   "accommodation":"Historic Hotel Vienna",     "check_in":"2026-04-15","check_out":"2026-04-20","guests":6,"total":1800,"status":"CONFIRMED"},
    {"id":23, "user":"john_doe",      "accommodation":"Lakeview Cabin Tahoe",      "check_in":"2026-05-01","check_out":"2026-05-05","guests":2,"total":1000,"status":"CONFIRMED"},
    {"id":24, "user":"jane_smith",    "accommodation":"Contemporary Condo Sydney", "check_in":"2026-06-01","check_out":"2026-06-05","guests":4,"total":1200,"status":"CONFIRMED"},
    {"id":25, "user":"alice_johnson", "accommodation":"Countryside Cottage Cotswolds","check_in":"2026-07-10","check_out":"2026-07-15","guests":3,"total":900,"status":"CONFIRMED"},
]

REVIEWS = [
    {"user":"bob_brown",     "accommodation":"Boutique Hotel Lisbon",      "rating":4, "comment":"Good stay overall, but the air conditioning was a bit noisy.",   "date":"2024-05-04"},
    {"user":"charlie_davis", "accommodation":"Beachfront Bungalow Bali",   "rating":3, "comment":"Good location, but the place felt a bit dated.",               "date":"2024-05-05"},
    {"user":"john_doe",      "accommodation":"Luxury Hotel Paris",         "rating":4, "comment":"Wonderful stay, great location, but check-in could be faster.", "date":"2025-05-06"},
    {"user":"jane_smith",    "accommodation":"Cozy Apartment Montmartre",  "rating":5, "comment":"Amazing apartment with a great view! Very comfortable.",        "date":"2025-06-16"},
    {"user":"diana_evans",   "accommodation":"Seaside Villa Amalfi",       "rating":4, "comment":"The resort was nice, but the beach was a bit crowded.",         "date":"2025-10-06"},
    {"user":"jane_smith",    "accommodation":"City Apartment Tokyo",       "rating":5, "comment":"The cabin was perfect for a winter getaway. Very cozy!",        "date":"2025-12-06"},
    {"user":"alice_johnson", "accommodation":"Eco Cottage Quebec",         "rating":4, "comment":"Great location and very comfortable, but Wi-Fi was spotty.",    "date":"2026-01-16"},
    {"user":"diana_evans",   "accommodation":"Historic Hotel Vienna",      "rating":5, "comment":"Fantastic stay, the hotel exceeded our expectations!",          "date":"2026-04-21"},
    {"user":"john_doe",      "accommodation":"Lakeview Cabin Tahoe",       "rating":4, "comment":"Nice place, but the parking was a bit far from the entrance.",  "date":"2026-05-06"},
    {"user":"jane_smith",    "accommodation":"Contemporary Condo Sydney",  "rating":4, "comment":"Great condo, but the kitchen could use more utensils.",         "date":"2026-06-06"},
    {"user":"alice_johnson", "accommodation":"Countryside Cottage Cotswolds","rating":5,"comment":"Perfect stay, everything was as expected and the view was stunning!", "date":"2026-07-16"},
]

df_acc  = pd.DataFrame(ACCOMMODATIONS)
df_book = pd.DataFrame(BOOKINGS)
df_rev  = pd.DataFrame(REVIEWS)
df_book["check_in"]  = pd.to_datetime(df_book["check_in"])
df_book["check_out"] = pd.to_datetime(df_book["check_out"])

STARS = {1:"★☆☆☆☆", 2:"★★☆☆☆", 3:"★★★☆☆", 4:"★★★★☆", 5:"★★★★★"}
TYPE_EMOJI = {"hotel":"🏨","apartment":"🏢","villa":"🏖️","chalet":"🏔️","cottage":"🏡","cabin":"🪵","condo":"🏙️"}

# ─── SIDEBAR ───────────────────────────────────────────────────────────────────
with st.sidebar:
    st.markdown("## 🏨 Booking App")
    st.markdown("*Demo dashboard — Java OOP Project*")
    st.divider()
    page = st.radio("Navigation", ["🏠 Accueil & KPIs", "🔍 Hébergements", "📅 Réservations", "💬 Avis", "🗺️ Carte"])
    st.divider()
    st.markdown("**Connexion démo**")
    st.code("admin / admin123\njohn_doe / password123")
    st.caption("Java app: [télécharger JAR](https://github.com/Kycks912004/projet-java-ing3/releases/latest)")

# ─── PAGE : ACCUEIL ────────────────────────────────────────────────────────────
if page == "🏠 Accueil & KPIs":
    st.title("🏨 Booking Application")
    st.markdown("*Réservation d'hébergements — Java OOP · Swing · SQLite · MVC · JFreeChart*")
    st.divider()

    confirmed = df_book[df_book["status"] == "CONFIRMED"]
    col1, col2, col3, col4 = st.columns(4)
    col1.metric("Hébergements", len(df_acc), "12 destinations")
    col2.metric("Réservations", len(df_book), f"{len(confirmed)} confirmées")
    col3.metric("Revenus totaux", f"{confirmed['total'].sum():,.0f} €")
    col4.metric("Note moyenne", f"{df_rev['rating'].mean():.1f} / 5", f"{len(df_rev)} avis")

    st.divider()
    col_a, col_b = st.columns(2)

    with col_a:
        st.subheader("Réservations par statut")
        status_count = df_book["status"].value_counts().reset_index()
        status_count.columns = ["Statut", "Nombre"]
        fig = px.pie(status_count, names="Statut", values="Nombre",
                     color_discrete_map={"CONFIRMED":"#6366f1","CANCELLED":"#ef4444"},
                     hole=0.45)
        fig.update_layout(margin=dict(t=20,b=20), height=280)
        st.plotly_chart(fig, use_container_width=True)

    with col_b:
        st.subheader("Prix / nuit par type d'hébergement")
        fig2 = px.box(df_acc, x="type", y="price", color="type",
                      labels={"type":"Type","price":"Prix/nuit (€)"},
                      color_discrete_sequence=px.colors.qualitative.Pastel)
        fig2.update_layout(showlegend=False, height=280, margin=dict(t=20,b=20))
        st.plotly_chart(fig2, use_container_width=True)

    st.subheader("Revenus par hébergement (réservations confirmées)")
    rev_by_acc = confirmed.groupby("accommodation")["total"].sum().sort_values(ascending=True).reset_index()
    fig3 = px.bar(rev_by_acc, x="total", y="accommodation", orientation="h",
                  labels={"total":"Revenus (€)","accommodation":""},
                  color="total", color_continuous_scale="Purples")
    fig3.update_layout(height=380, margin=dict(t=20,b=20), coloraxis_showscale=False)
    st.plotly_chart(fig3, use_container_width=True)

# ─── PAGE : HÉBERGEMENTS ───────────────────────────────────────────────────────
elif page == "🔍 Hébergements":
    st.title("🔍 Hébergements")
    st.divider()

    col1, col2, col3 = st.columns(3)
    with col1:
        cities = ["Toutes"] + sorted(df_acc["city"].unique().tolist())
        city_filter = st.selectbox("Ville", cities)
    with col2:
        types = ["Tous"] + sorted(df_acc["type"].unique().tolist())
        type_filter = st.selectbox("Type", types)
    with col3:
        max_price = st.slider("Prix max / nuit (€)", 50, 500, 500, step=10)

    amenity_filter = st.multiselect("Équipements requis", ["WiFi", "Piscine", "Parking", "Restaurant", "Climatisation"])

    filtered = df_acc.copy()
    if city_filter != "Toutes":
        filtered = filtered[filtered["city"] == city_filter]
    if type_filter != "Tous":
        filtered = filtered[filtered["type"] == type_filter]
    filtered = filtered[filtered["price"] <= max_price]
    if "WiFi"          in amenity_filter: filtered = filtered[filtered["wifi"]]
    if "Piscine"       in amenity_filter: filtered = filtered[filtered["pool"]]
    if "Parking"       in amenity_filter: filtered = filtered[filtered["parking"]]
    if "Restaurant"    in amenity_filter: filtered = filtered[filtered["restaurant"]]
    if "Climatisation" in amenity_filter: filtered = filtered[filtered["ac"]]

    st.caption(f"{len(filtered)} hébergement(s) trouvé(s)")
    st.divider()

    for i in range(0, len(filtered), 3):
        cols = st.columns(3)
        for j, col in enumerate(cols):
            if i + j >= len(filtered): break
            row = filtered.iloc[i + j]
            with col:
                img_path = IMG_DIR / row["img"]
                if img_path.exists():
                    st.image(str(img_path), use_container_width=True)
                emoji = TYPE_EMOJI.get(row["type"], "🏠")
                st.markdown(f"**{emoji} {row['name']}**")
                st.markdown(f"📍 {row['city']}, {row['country']}")
                st.markdown(f"💶 **{row['price']} €** / nuit · 👥 {row['guests']} pers.")
                stars = STARS.get(int(row["rating"]), "")
                if stars:
                    st.markdown(f"<span style='color:#f59e0b'>{stars}</span>", unsafe_allow_html=True)
                amenities = []
                if row["wifi"]:       amenities.append("📶 WiFi")
                if row["pool"]:       amenities.append("🏊 Piscine")
                if row["parking"]:    amenities.append("🅿️ Parking")
                if row["restaurant"]: amenities.append("🍽️ Restaurant")
                if row["ac"]:         amenities.append("❄️ Clim")
                if amenities:
                    st.caption(" · ".join(amenities))
                with st.expander("Description"):
                    st.write(row["desc"])
                st.divider()

# ─── PAGE : RÉSERVATIONS ───────────────────────────────────────────────────────
elif page == "📅 Réservations":
    st.title("📅 Réservations")
    st.divider()

    status_f = st.radio("Filtrer", ["Toutes", "CONFIRMED", "CANCELLED"], horizontal=True)
    shown = df_book if status_f == "Toutes" else df_book[df_book["status"] == status_f]

    def color_status(val):
        return "color: #22c55e; font-weight:600" if val == "CONFIRMED" else "color: #ef4444; font-weight:600"

    display = shown[["id","user","accommodation","check_in","check_out","guests","total","status"]].copy()
    display.columns = ["#","Utilisateur","Hébergement","Arrivée","Départ","Voyageurs","Total (€)","Statut"]
    st.dataframe(
        display.style.applymap(color_status, subset=["Statut"]),
        use_container_width=True, hide_index=True
    )

    st.divider()
    st.subheader("Évolution des réservations dans le temps")
    timeline = df_book.sort_values("check_in").copy()
    timeline["mois"] = timeline["check_in"].dt.to_period("M").astype(str)
    by_month = timeline.groupby("mois").agg(nb=("id","count"), revenus=("total","sum")).reset_index()

    fig = go.Figure()
    fig.add_bar(x=by_month["mois"], y=by_month["nb"], name="Nb réservations", marker_color="#6366f1")
    fig.add_scatter(x=by_month["mois"], y=by_month["revenus"] / 100, mode="lines+markers",
                    name="Revenus (÷100)", line=dict(color="#f59e0b", width=2))
    fig.update_layout(height=320, margin=dict(t=20,b=20), xaxis_tickangle=-45,
                      legend=dict(orientation="h", yanchor="bottom", y=1.02))
    st.plotly_chart(fig, use_container_width=True)

# ─── PAGE : AVIS ───────────────────────────────────────────────────────────────
elif page == "💬 Avis":
    st.title("💬 Avis Clients")
    st.divider()

    col1, col2 = st.columns([2, 1])
    with col1:
        rating_filter = st.slider("Note minimum", 1, 5, 1)
    with col2:
        sort_by = st.selectbox("Trier par", ["Date (récent)", "Note (haute)", "Note (basse)"])

    shown_rev = df_rev[df_rev["rating"] >= rating_filter].copy()
    if sort_by == "Date (récent)":
        shown_rev = shown_rev.sort_values("date", ascending=False)
    elif sort_by == "Note (haute)":
        shown_rev = shown_rev.sort_values("rating", ascending=False)
    else:
        shown_rev = shown_rev.sort_values("rating", ascending=True)

    for _, r in shown_rev.iterrows():
        stars_str = "⭐" * int(r["rating"])
        st.markdown(f"""
<div style='background:rgba(99,102,241,0.07);border:1px solid rgba(99,102,241,0.2);border-radius:10px;padding:1rem;margin-bottom:0.75rem;'>
<b>{stars_str}</b> &nbsp; <b>{r['accommodation']}</b><br>
<span style='color:#8b949e;font-size:0.85rem;'>👤 {r['user']} · 📅 {r['date']}</span><br>
<i style='color:#e6edf3;'>{r['comment']}</i>
</div>""", unsafe_allow_html=True)

    st.divider()
    st.subheader("Distribution des notes")
    dist = df_rev["rating"].value_counts().sort_index().reset_index()
    dist.columns = ["Note", "Nb avis"]
    dist["Étoiles"] = dist["Note"].map(lambda x: "⭐"*x)
    fig = px.bar(dist, x="Note", y="Nb avis", text="Nb avis",
                 color="Note", color_continuous_scale=["#ef4444","#f59e0b","#22c55e","#6366f1","#8b5cf6"])
    fig.update_traces(textposition="outside")
    fig.update_layout(height=280, showlegend=False, coloraxis_showscale=False, margin=dict(t=20,b=20))
    st.plotly_chart(fig, use_container_width=True)

# ─── PAGE : CARTE ──────────────────────────────────────────────────────────────
elif page == "🗺️ Carte":
    st.title("🗺️ Carte des Hébergements")
    st.divider()

    fig = px.scatter_mapbox(
        df_acc, lat="lat", lon="lon",
        hover_name="name",
        hover_data={"city":True,"country":True,"price":True,"rating":True,"lat":False,"lon":False},
        color="price",
        size="price",
        color_continuous_scale="Purples",
        size_max=20,
        zoom=1,
        mapbox_style="carto-positron",
        labels={"price":"Prix/nuit (€)","rating":"Note"},
    )
    fig.update_layout(height=560, margin=dict(t=0,b=0,l=0,r=0))
    st.plotly_chart(fig, use_container_width=True)

    st.subheader("Détails par destination")
    cols = st.columns(4)
    for i, row in df_acc.iterrows():
        with cols[i % 4]:
            st.metric(
                label=f"{TYPE_EMOJI.get(row['type'],'🏠')} {row['city']}",
                value=f"{row['price']} €/nuit",
                delta=f"{STARS[int(row['rating'])]}"
            )
