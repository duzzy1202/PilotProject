<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script>
	var locationReload = '${locationReload}' == 'true';
	var historyBack = '${historyBack}' == 'true';
	var alertMsg = '${alertMsg}'.trim();
	if (alertMsg) {
		alert(alertMsg);
	}
	if (historyBack) {
		history.back();
	}
	var redirectUri = '${redirectUri}'.trim();
	if (locationReload) {
		location.reload(redirectUri);
	}
	if (redirectUri) {
		location.replace(redirectUri);
	}
	var redirectUriHref = '${redirectUriHref}'.trim();
	if (redirectUriHref) {
		location.href(redirectUriHref);
	}
</script>