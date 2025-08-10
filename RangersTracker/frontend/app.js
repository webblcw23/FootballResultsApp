const apiBase = (window.location.origin.includes('azurestatic') || window.location.host.includes('.web.core.windows.net'))
    ? (window.API_BASE || '/api') // if using SWA routing, otherwise we’ll set a full URL via config
    : '/api';

async function fetchJson(url) {
    const res = await fetch(url, { headers: { 'cache-control': 'no-cache' } });
    if (!res.ok) throw new Error(`HTTP ${res.status}`);
    return res.json();
}

function renderList(el, items, transform) {
    el.innerHTML = items.map(transform).join('');
}

function formatDate(iso) {
    const d = new Date(iso);
    return d.toLocaleDateString(undefined, { weekday: 'short', day: '2-digit', month: 'short' });
}

(async () => {
    const resultsEl = document.getElementById('results');
    const fixturesEl = document.getElementById('fixtures');
    try {
        const [results, fixtures] = await Promise.all([
            fetchJson(`${apiBase}/results`),
            fetchJson(`${apiBase}/fixtures`)
        ]);

        renderList(resultsEl, results.slice(0, 5), m => `
      <li class="card">
        <span>${formatDate(m.date)} — ${m.opponent}</span>
        <span class="badge">${m.score || '—'}</span>
      </li>
    `);

        renderList(fixturesEl, fixtures.slice(0, 5), m => `
      <li class="card">
        <span>${formatDate(m.date)} — ${m.opponent}</span>
        <span class="badge">${m.competition}</span>
      </li>
    `);
    } catch (err) {
        resultsEl.innerHTML = `<li class="card">Couldn’t load data. Try again later.</li>`;
        fixturesEl.innerHTML = `<li class="card">Couldn’t load data. Try again later.</li>`;
        console.error(err);
    }
})();
