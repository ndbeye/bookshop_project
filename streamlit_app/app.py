import os  
import snowflake.connector  
import configparser  
import streamlit as st  # Assurez-vous d'importer Streamlit  

# Charger le fichier de configuration  
config = configparser.ConfigParser()  
config_path = r'C:\Users\ndiaga.beye\Desktop\Cours-MIA-DIT\MIA2\Projet_Big_Data\bookshop_project\streamlit_app\config.ini'  
config.read(config_path)  

# Afficher les sections disponibles pour le débogage  
st.write("Sections disponibles :", config.sections())  

try:  
    # Extraire les informations de connexion  
    account = config['connections.my_example_connection']['account']  
    user = os.getenv("USER", config['connections.my_example_connection']['user'])  
    password = os.getenv("PASSWORD", config['connections.my_example_connection']['password'])  
    role = config['connections.my_example_connection']['role']  
    warehouse = config['connections.my_example_connection']['warehouse']  
    database = config['connections.my_example_connection']['database']  
    schema = config['connections.my_example_connection']['schema']  

    # Établir la connexion à Snowflake  
    conn = snowflake.connector.connect(  
        account=account,  
        user=user,  
        password=password,  
        role=role,  
        warehouse=warehouse,  
        database=database,  
        schema=schema  
    )  
    st.write("Connecté à Snowflake avec succès !")  

    # Exemple de requête pour récupérer des données  
    query = "SELECT * FROM your_table_name LIMIT 10;"  # Remplacez 'your_table_name' par le nom de votre table  
    cursor = conn.cursor()  
    cursor.execute(query)  
    data = cursor.fetchall()  

    # Afficher les résultats dans Streamlit  
    if data:  
        st.write(data)  # Afficher les données récupérées  
    else:  
        st.write("Aucune donnée trouvée.")  

except configparser.NoSectionError:  
    st.error("Erreur : La section 'connections.my_example_connection' est manquante dans le fichier de configuration.")  
except KeyError as e:  
    st.error(f"Erreur : La clé '{e}' est manquante dans la section 'connections.my_example_connection'.")  
except Exception as e:  
    st.error(f"La connexion à Snowflake a échoué : {e}")  