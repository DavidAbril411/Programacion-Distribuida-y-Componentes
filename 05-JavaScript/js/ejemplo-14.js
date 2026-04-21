var jUtils = {

	setTmpCount: () => {
		if (typeof(Storage) !== undefined) {
			if (sessionStorage.clickcount) {
				sessionStorage.clickcount = Number(sessionStorage.clickcount) + 1;
			}
			else {
				sessionStorage.clickcount = 1;
			}
			document.getElementById("tmp").innerHTML = sessionStorage.clickcount;
		}
	},

	setGlobalCount: () => {
		if (typeof(Storage) !== undefined) {
			if (localStorage.clickcount) {
				localStorage.clickcount = Number(localStorage.clickcount) + 1;
			}
			else {
				localStorage.clickcount = 1;
			}
			document.getElementById("global").innerHTML = localStorage.clickcount;
		}
	}
	
};

document.addEventListener('DOMContentLoaded', () => {
	if (typeof(Storage) !== undefined) {
		document.getElementById("global").innerHTML = localStorage.clickcount ?? "0";
		document.getElementById("tmp").innerHTML = sessionStorage.clickcount ?? "0";
	}
	else {
		document.write("<p>Su navegador no soporta almacenamiento Web</p>");
	}

	with(document) {
		getElementById("ibtnTmp").addEventListener("click", () => {
			jUtils.setTmpCount();
		});

		getElementById("ibtnGlobal").addEventListener("click", () => {
			jUtils.setGlobalCount();
		});
	}
});	