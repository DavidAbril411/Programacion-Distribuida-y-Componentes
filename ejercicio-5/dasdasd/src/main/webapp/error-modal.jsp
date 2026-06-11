<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Modal de Error -->
<div class="modal fade" id="errorModal" tabindex="-1" aria-labelledby="errorModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="errorModalLabel">Error</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                ${!empty error ? error : exception}
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    (function(){
        let shown = false;

        function showMessage() {
            if (shown)
                return;

            const modal = document.getElementById('errorModal');
            if (!modal)
                return;

            if (modal.parentElement !== document.body) {
                document.body.appendChild(modal);
            }

            new bootstrap.Modal(modal, { backdrop: true, keyboard: true, focus: true }).show();
            shown = true;

            document.removeEventListener('DOMContentLoaded', showMessage);
            observer.disconnect();
        }

        if (window.bootstrap && document.readyState !== 'loading') {
            showMessage();
        }

        document.addEventListener('DOMContentLoaded', showMessage, { once: true });

        const observer = new MutationObserver((_, obs) => {
            showMessage() && obs.disconnect();
        });
        observer.observe(document.body, { childList: true, subtree: true });
    })();
</script>
