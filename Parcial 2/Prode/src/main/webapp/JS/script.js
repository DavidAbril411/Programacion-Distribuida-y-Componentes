document.getElementById('iForm').addEventListener('submit', async (event) => {
    try {
        event.preventDefault();
        jUtils.clean("iError");

        jUtils.showLoading();

        const data = new FormData(event.target);

        const response = await fetch("results.jsp", {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded",
            },
            body: new URLSearchParams(data)
        });

        if (!response.ok) {
            const text = await response.text();
            throw new Error(text || response.statusText);
        }

        console.log(await response.text());
        event.target.reset();

    } catch (error) {
        console.log(error);
        jUtils.show("iError", error.message);
    } finally {
        jUtils.hideLoading();
    }
})