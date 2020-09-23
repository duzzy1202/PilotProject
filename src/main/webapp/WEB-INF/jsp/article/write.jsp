<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="${board.name} 게시물 작성" />
<%@ include file="../part/head.jspf"%>
<%@ include file="../part/toastuiEditor.jspf"%>

<!-- 작성 수정 CSS -->
<link rel="stylesheet" href="/resource/css/write.css" />

<script>
	var ArticleWriteForm__submitDone = false;

	function ArticleWriteForm__submit(form) {
		if (ArticleWriteForm__submitDone) {
			alert('처리중입니다.');
			return;
		}

		form.title.value = form.title.value.trim();

		if (form.title.value.length == 0) {
			form.title.focus();
			alert('제목을 입력해주세요.');

			return;
		}

		var bodyEditor = $(form).find('.toast-editor.input-body').data(
				'data-toast-editor');

		var body = bodyEditor.getMarkdown().trim();

		if (body.length == 0) {
			bodyEditor.focus();
			alert('내용을 입력해주세요.');

			return;
		}

		form.body.value = body;

		var maxSizeMb = 50;
		var maxSize = maxSizeMb * 1024 * 1024 //50MB

		if (form.file__article__0__common__attachment__1.value) {
			if (form.file__article__0__common__attachment__1.files[0].size > maxSize) {
				alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
				return;
			}
		}

		if (form.file__article__0__common__attachment__2.value) {
			if (form.file__article__0__common__attachment__2.files[0].size > maxSize) {
				alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
				return;
			}
		}

		if (form.file__article__0__common__attachment__3.value) {
			if (form.file__article__0__common__attachment__3.files[0].size > maxSize) {
				alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
				return;
			}
		}

		var startUploadFiles = function(onSuccess) {
			var needToUpload = form.file__article__0__common__attachment__1.value.length > 0;

			if (!needToUpload) {
				needToUpload = form.file__article__0__common__attachment__2.value.length > 0;
			}

			if (!needToUpload) {
				needToUpload = form.file__article__0__common__attachment__3.value.length > 0;
			}

			if (needToUpload == false) {
				onSuccess();
				return;
			}

			var fileUploadFormData = new FormData(form);

			$.ajax({
				url : '/usr/file/doUploadAjax',
				data : fileUploadFormData,
				processData : false,
				contentType : false,
				dataType : "json",
				type : 'POST',
				success : onSuccess
			});
		}

		startUploadFiles(function(data) {
			var fileIdsStr = '';

			if (data && data.body && data.body.fileIdsStr) {
				fileIdsStr = data.body.fileIdsStr;
			}

			form.fileIdsStr.value = fileIdsStr;
			form.file__article__0__common__attachment__1.value = '';
			form.file__article__0__common__attachment__2.value = '';

			if (bodyEditor.inBodyFileIdsStr) {
				form.fileIdsStr.value += bodyEditor.inBodyFileIdsStr;
			}

			form.submit();
			ArticleWriteForm__submitDone = true;
		});
	}
</script>
<div class="write con">
	<div class="empty-space"></div>
	<span>${board.name} 게시판 글작성</span>
	<form method="POST" class="write-box" action="${board.code}-doWrite" onsubmit="ArticleWriteForm__submit(this); return false;">
		<input type="hidden" name="fileIdsStr" /> 
		<input type="hidden" name="body" /> 
		<input type="hidden" name="redirectUri" value="/usr/article/${board.code}-detail?id=#id">

		<div class="title-box">
			<input type="text" placeholder="제목을 입력해주세요." name="title" maxlength="60" />
		</div>
		<div class="body-box">
			<script type="text/x-template">

            </script>
			<div data-relTypeCode="article" data-relId="0" class="toast-editor input-body"></div>
		</div>
		<div class="button-box">
			<button class="button" type="submit">작성</button>
			<button class="button" onclick="location.href='${listUrl}'; return false;">이전</button>
		</div>
	</form>
</div>

<%@ include file="../part/foot.jspf"%>