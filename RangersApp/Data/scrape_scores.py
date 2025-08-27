#import pandas as pd
import json

# Source CSV for 2025–2026 Scottish Premiership
url = "https://www.football-data.co.uk/mmz4281/2526/SC0.csv"
df = pd.read_csv(url)
df.to_csv("Data/SC0_2025.csv", index=False)


# Filter for Rangers matches
rangers_df = df[(df['HomeTeam'] == 'Rangers') | (df['AwayTeam'] == 'Rangers')]

# 🔹 Past results (with scores)
past_df = rangers_df[rangers_df['FTHG'].notna() & rangers_df['FTAG'].notna()]
past_matches = []
for _, row in past_df.iterrows():
    past_matches.append({
        "date": row["Date"],
        "home": row["HomeTeam"],
        "away": row["AwayTeam"],
        "venue": "Home" if row["HomeTeam"] == "Rangers" else "Away",
        "score": f"{int(row['FTHG'])}-{int(row['FTAG'])}"
    })

with open("/app/Data/rangers-results.json") as f:
    json.dump(past_matches, f, indent=2)


# Can now delete the CSV file if not needed
import os

csv_path = os.path.join("Data", "SC0_2025.csv")
print("Resolved path:", os.path.abspath(csv_path))

if os.path.exists(csv_path):
    os.remove(csv_path)
    print("CSV file deleted.")
else:
    print("CSV file not found — nothing to delete.")



# to run this script - python3 Data/scrape_scores.py