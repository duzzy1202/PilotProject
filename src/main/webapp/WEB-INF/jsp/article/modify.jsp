<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="${board.name} 게시물 상세내용" />
<%@ include file="../part/head.jspf"%>
<%@ include file="../part/toastuiEditor.jspf"%>

<!-- 작성 수정 CSS -->
<link rel="stylesheet" href="/resource/css/write.css" />

<script>

	var ArticleModifyForm__submitDone = false;

	function ArticleModifyForm__submit(form) {
		if (ArticleModifyForm__submitDone = false) {
			alert('처리중입니다.');
			return;
		}

		var fileInput1 = form["file__article__" + ${article.id} + "__common__attachment__1"];
		var fileInput2 = form["file__article__" + ${article.id} + "__common__attachment__2"];
		var fileInput3 = form["file__article__" + ${article.id} + "__common__attachment__3"];

		var deleteFileInput1 = form["deleteFile__article__" + ${article.id} + "__common__attachment__1"];
		var deleteFileInput2 = form["deleteFile__article__" + ${article.id} + "__common__attachment__2"];
		var deleteFileInput3 = form["deleteFile__article__" + ${article.id} + "__common__attachment__3"];

		if (fileInput1 && deleteFileInput1) {
			if (deleteFileInput1.checked) {
				fileInput1.value = '';
			}
		}

		if (fileInput2 && deleteFileInput2) {
			if (deleteFileInput2.checked) {
				fileInput2.value = '';
			}
		}

		if (fileInput3 && deleteFileInput3) {
			if (deleteFileInput3.checked) {
				fileInput3.value = '';
			}
		}

		form.title.value = form.title.value.trim();

		if (form.title.value.length == 0) {
			form.title.focus();
			alert('제목을 입력해주세요.');

			return;
		}

		var bodyEditor = $(form).find('.toast-editor.input-body').data('data-toast-editor');

		var body = bodyEditor.getMarkdown().trim();

		if (body.length == 0) {
			bodyEditor.focus();
			alert('내용을 입력해주세요.');

			return;
		}

		form.body.value = body;

		var maxSizeMb = 50;
		var maxSize = maxSizeMb * 1024 * 1024 //50MB

		if (fileInput1 && fileInput1.value) {
			if (fileInput1.files[0].size > maxSize) {
				alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
				return;
			}
		}

		if (fileInput2 && fileInput2.value) {
			if (fileInput2.files[0].size > maxSize) {
				alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
				return;
			}
		}

		if (fileInput3 && fileInput3.value) {
			if (fileInput3.files[0].size > maxSize) {
				alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
				return;
			}
		}

		var startUploadFiles = function(onSuccess) {
			var needToUpload = false;

			if (!needToUpload) {
				needToUpload = fileInput1 && fileInput1.value.length > 0;
			}

			if (!needToUpload) {
				needToUpload = deleteFileInput1 && deleteFileInput1.checked;
			}

			if (!needToUpload) {
				needToUpload = fileInput2 && fileInput2.value.length > 0;
			}

			if (!needToUpload) {
				needToUpload = deleteFileInput2 && deleteFileInput2.checked;
			}

			if (!needToUpload) {
				needToUpload = fileInput3 && fileInput3.value.length > 0;
			}

			if (!needToUpload) {
				needToUpload = deleteFileInput3 && deleteFileInput3.checked;
			}

			if (needToUpload == false) {
				onSuccess();
				return;
			}

			var fileUploadFormData = new FormData(form);

			$.ajax({
				url : './../file/doUploadAjax',
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

			if (bodyEditor.inBodyFileIdsStr) {
				form.fileIdsStr.value += bodyEditor.inBodyFileIdsStr;
			}

			if (fileInput1) {
				fileInput1.value = '';
			}

			if (fileInput2) {
				fileInput2.value = '';
			}

			if (fileInput3) {
				fileInput3.value = '';
			}
			
			ArticleModifyForm__submitDone = true;
			form.submit();
			
		});
	}
</script>

<div class="write con">
	<div class="empty-space"></div>
	<span>${board.name} 게시판 글수정</span>
	<form class="write-box" method="POST" action="${board.code}-doModify" onsubmit="ArticleModifyForm__submit(this); return false;">
		<input type="hidden" name="fileIdsStr" /> 
		<input type="hidden" name="body" /> 
		<input type="hidden" name="redirectUri" value="/usr/article/${board.code}-detail?id=${article.id}">
		<input type="hidden" name="id" value="${article.id}" />

		<div class="title-box">
			<input type="text" value="${article.title}" placeholder="제목을 입력해주세요." name="title" maxlength="60" />
		</div>
		<div class="body-box">
			<script type="text/x-template">${article.body}</script>
			<div data-relTypeCode="artile" data-relId="${article.id}" class="toast-editor input-body"></div>
		</div>
		<div class="button-box">
			<button class="button" type="submit">수정</button>
			<button class="button" onclick="location.href='${listUrl}'; return false;">목록</button>
		</div>
	</form>
</div>



<%@ include file="../part/foot.jspf"%>