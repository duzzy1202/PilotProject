<%@ page import="com.ljh.footballaround.util.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="${board.name} 게시물 상세내용" />
<%@ include file="../part/head.jspf"%>
<%@ include file="../part/toastuiEditor.jspf"%>

<!-- 리스트 CSS -->
<link rel="stylesheet" href="/resource/css/detail.css" />

<div class="article-detail con">
	<div class="article-detail-thead"></div>
	<div class="detail-boardname">
		<span><a href="/usr/article/${board.code}-list">${board.name} 게시판</a></span>
	</div>
	<div class="detail-table">
		<div class="detail-box-title">
			<div class="detail-title">${article.forPrintTitle}</div>
		</div>
		<div class="detail-box-etc">
			<div class="detail-writer">${article.extra.writer}</div>
			<div class="detail-regDate">${article.regDate}</div>
		</div>
		<div class="detail-body">
			<script type="text/x-template">${article.body}</script>
            <div class="toast-editor toast-editor-viewer"></div>
		</div>
		<c:forEach var="i" begin="1" end="3" step="1">
			<c:set var="fileNo" value="${String.valueOf(i)}" />
			<c:set var="file" value="${article.extra.file__common__attachment[fileNo]}" />
			<c:if test="${file != null}">
				<div>
					<span>첨부파일 ${fileNo}</span>
					<span>
						<c:if test="${file.fileExtTypeCode == 'video'}">
							<div class="video-box">
								<video controls src="/file/streamVideo?id=${file.id}&updateDate=${file.updateDate}"></video>
							</div>
						</c:if>
						<c:if test="${file.fileExtTypeCode == 'img'}">
							<div class="img-box img-box-auto">
								<img src="/file/img?id=${file.id}&updateDate=${file.updateDate}" alt="" />
							</div>
						</c:if>
					</span>
				</div>
			</c:if>
		</c:forEach>
	</div>
</div>

<div class="button-box con">
	<c:if test="${article.extra.actorCanModify}">
		<a class="article-modibtn artbtn" href="${board.code}-modify?id=${article.id}&listUrl=${Util.getUriEncoded(listUrl)}">수정</a>
	</c:if>
	<c:if test="${article.extra.actorCanDelete}">
		<a class="article-delbtn artbtn" href="${board.code}-doDelete?id=${article.id}" onclick="if ( confirm('삭제하시겠습니까?') == false ) return false;">삭제</a>
	</c:if>
	<c:if test="${isLoggedIn && article.memberId != loggedInMemberId}">
		<a class="article-repbtn artbtn" href="doSendReport?id=${article.id}&reportedType=Article&reportedReason=그냥" onclick="if ( confirm('신고하시겠습니까?') == false ) return false;">신고</a>
	</c:if>

	<a href="${listUrl}" class="article-listbtn artbtn">목록</a>
</div>

<c:if test="${isLoggedIn}">
	<h2 class="con">댓글</h2>

	<script>
		var WriteReplyForm__submitDone = false;
	
		function WriteReplyForm__submit(form) {
			
			if (WriteReplyForm__submitDone = false) {
				alert('처리중입니다.');
			}

			form.body.value = form.body.value.trim();
			if (form.body.value.length == 0) {
				alert('댓글을 입력해주세요.');
				form.body.focus();
				return;
			}

			var startUploadFiles = function(onSuccess) {
				var needToUpload = false;

				if (needToUpload == false) {
					needToUpload = form.file__reply__0__common__attachment__1 && form.file__reply__0__common__attachment__1.value.length > 0;
				}

				if (needToUpload == false) {
					needToUpload = form.file__reply__0__common__attachment__2 && form.file__reply__0__common__attachment__2.value.length > 0;
				}

				if (needToUpload == false) {
					needToUpload = form.file__reply__0__common__attachment__3 && form.file__reply__0__common__attachment__3.value.length > 0;
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

			var startWriteReply = function(fileIdsStr, onSuccess) {

				$.ajax({
					url : './../reply/doWriteReplyAjax',
					data : {
						fileIdsStr : fileIdsStr,
						body : form.body.value,
						relTypeCode : form.relTypeCode.value,
						relId : form.relId.value
					},
					dataType : "json",
					type : 'POST',
					success : onSuccess
				});
			};

			startUploadFiles(function(data) {

				var idsStr = '';
				if (data && data.body && data.body.fileIdsStr) {
					idsStr = data.body.fileIdsStr;
				}

				startWriteReply(idsStr, function(data) {

					if (data.msg) {
						alert(data.msg);
					}

					form.body.value = '';

					if (form.file__reply__0__common__attachment__1) {
						form.file__reply__0__common__attachment__1.value = '';
					}

					if (form.file__reply__0__common__attachment__2) {
						form.file__reply__0__common__attachment__2.value = '';
					}

					if (form.file__reply__0__common__attachment__3) {
						form.file__reply__0__common__attachment__3.value = '';
					}

					WriteReplyForm__submitDone = true;
				});
			});
		}
	</script>

	<form class="reply-write con" onsubmit="WriteReplyForm__submit(this); return false;">
		<input type="hidden" name="relTypeCode" value="article" />
		<input type="hidden" name="relId" value="${article.id}" />
		<input type="hidden" name="id" value="${article.id}" />
		
		<div class="reply-write-box">
			<div class="write-box">
				<div class="reply-text-box-th">댓글</div>
				<div class="reply-text-box">
					<textarea maxlength="300" name="body" placeholder="내용을 입력해주세요."></textarea>
				</div>
			</div>
		</div>
		<div class="button-box">
			<c:forEach var="i" begin="1" end="1" step="1">
			<c:set var="fileNo" value="${String.valueOf(i)}" />
			<c:set var="fileExtTypeCode" value="${appConfig.getAttachmentFileExtTypeCode('reply', i)}" />
			<div class="file-th">파일 첨부 ${appConfig.getAttachmentFileExtTypeDisplayName('reply', i)}</div>
			<div class="file-control">
				<input type="file" accept="${appConfig.getAttachemntFileInputAccept('article', i)}" name="file__reply__0__common__attachment__${fileNo}">
			</div>
			</c:forEach>
			<input class="reply-submit" type="submit" value="댓글 등록">
		</div>
	</form>
	<div class="line"></div>
</c:if>

<style>
.reply-list-box .media-box > * {
    margin-top:10px;    
}

.reply-list-box .media-box > *:empty {
    display:none;
}

.reply-list-box .media-box > :first-chidl {
    margin-top:10px;
} 
</style>

<div class="reply-list-box con">
	<div class="reply-list">

	</div>
</div>

<style>
.reply-modify-form-modal-actived, reply-modify-form-modal-actived>body {
    overflow: hidden;
}

.reply-modify-form-modal {
    display: none;
}

.reply-modify-form-modal-actived .reply-modify-form-modal {
    display: flex;
}

.reply-modify-form-modal .video-box {
    width: 100px;
}

.reply-modify-form-modal .img-box {
    width: 100px;
}
</style>

<div class="popup-1 reply-modify-form-modal">
	<div>
		<h1>댓글 수정</h1>
		<form action="" class="form1 padding-10 table-box table-box-vertical" onsubmit="ReplyList__submitModifyForm(this); return false;">
			<input type="hidden" name="id" />
			<table>
				<colgroup>
					<col class="table-first-col">
				</colgroup>
				<tbody>
					<tr>
						<th>내용</th>
						<td>
							<div class="form-control-box">
								<textarea name="body" placeholder="내용을 입력해주세요."></textarea>
							</div>
						</td>
					</tr>

					<c:forEach var="i" begin="1" end="3" step="1">
						<c:set var="fileNo" value="${String.valueOf(i)}" />
						<c:set var="fileExtTypeCode" value="${appConfig.getAttachmentFileExtTypeCode('article', i)}" />

						<tr>
							<th>첨부${fileNo}</th>
							<td>
								<div class="form-control-box">
									<input type="file" accept="${appConfig.getAttachemntFileInputAccept('article', i)}" data-name="file__reply__0__common__attachment__${fileNo}">
								</div>
								<div style="width: 100%" class="video-box video-box-file-${fileNo}"></div>
								<div style="width: 100%" class="img-box img-box-auto img-box-file-${fileNo}"></div>
							</td>
						</tr>

						<tr>
							<th>첨부${fileNo} 삭제</th>
							<td>
								<div class="form-control-box">
									<label>
										<input type="checkbox" data-name="deleteFile__reply__0__common__attachment__${fileNo}" value="Y" />
										삭제
									</label>
								</div>
							</td>
						</tr>
					</c:forEach>
					<tr class="tr-do">
						<th>수정</th>
						<td>
							<button class="btn btn-primary" type="submit">수정</button>
							<button class="btn btn-info" type="button" onclick="ReplyList__hideModifyFormModal();">취소</button>
						</td>
					</tr>
				</tbody>
			</table>

		</form>
	</div>
</div>

<script>
	var ReplyList__$box = $('.reply-list-box');
	var ReplyList__$tbody = ReplyList__$box.find('.reply-list');

	var ReplyList__lastLodedId = 0;

	var ReplyList__submitModifyFormDone = false;
	
	function ReplyList__submitModifyForm(form) {
		if (ReplyList__submitModifyFormDone) {
			alert('처리중입니다.');
			return;
		}

		form.body.value = form.body.value.trim();

		if (form.body.value.length == 0) {
			alert('내용을 입력해주세요.');
			form.body.focus();

			return;
		}

		var id = form.id.value;
		var body = form.body.value;

		var fileInput1 = form['file__reply__' + id + '__common__attachment__1'];
		var fileInput2 = form['file__reply__' + id + '__common__attachment__2'];
		var fileInput3 = form['file__reply__' + id + '__common__attachment__3'];

		var deleteFileInput1 = form["deleteFile__reply__" + id + "__common__attachment__1"];
		var deleteFileInput2 = form["deleteFile__reply__" + id + "__common__attachment__2"];
		var deleteFileInput3 = form["deleteFile__reply__" + id + "__common__attachment__3"];

		if (fileInput1 && deleteFileInput1 && deleteFileInput1.checked) {
			fileInput1.value = '';
		}

		if (fileInput2 && deleteFileInput2 && deleteFileInput2.checked) {
			fileInput2.value = '';
		}

		if (fileInput3 && deleteFileInput3 && deleteFileInput3.checked) {
			fileInput3.value = '';
		}

		// 파일 업로드 시작
		var startUploadFiles = function() {
			var needToUpload = false;

			if (needToUpload == false) {
				needToUpload = fileInput1 && fileInput1.value.length > 0;
			}

			if (needToUpload == false) {
				needToUpload = deleteFileInput1 && deleteFileInput1.checked;
			}

			if (needToUpload == false) {
				needToUpload = fileInput2 && fileInput2.value.length > 0;
			}

			if (needToUpload == false) {
				needToUpload = deleteFileInput2 && deleteFileInput2.checked;
			}

			if (needToUpload == false) {
				needToUpload = fileInput3 && fileInput3.value.length > 0;
			}

			if (needToUpload == false) {
				needToUpload = deleteFileInput3 && deleteFileInput3.checked;
			}

			if (needToUpload == false) {
				onUploadFilesComplete();
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
				success : onUploadFilesComplete
			});
		}

		// 파일 업로드 완료시 실행되는 함수
		var onUploadFilesComplete = function(data) {

			var fileIdsStr = '';
			if (data && data.body && data.body.fileIdsStr) {
				fileIdsStr = data.body.fileIdsStr;
			}

			startModifyReply(fileIdsStr);
		};

		// 댓글 수정 시작
		var startModifyReply = function(fileIdsStr) {
			$.post('../reply/doModifyReplyAjax', {
				id : id,
				body : body,
				fileIdsStr : fileIdsStr
			}, onModifyReplyComplete, 'json');
		};

		// 댓글 수정이 완료되면 실행되는 함수
		var onModifyReplyComplete = function(data) {
			if (data.resultCode && data.resultCode.substr(0, 2) == 'S-') {
				// 성공시에는 기존에 그려진 내용을 수정해야 한다.!!
				$('.reply-list-box tbody > tr[data-id="' + id + '"]').data('data-originBody', body);
				$('.reply-list-box tbody > tr[data-id="' + id + '"] .reply-body').empty().append(getHtmlEncoded(body).replaceAll('\n', '<br>'));

				$('.reply-list-box tbody > tr[data-id="' + id + '"] .video-box').empty();
				$('.reply-list-box tbody > tr[data-id="' + id + '"] .img-box').empty();

				if (data && data.body && data.body.file__common__attachment) {
					for ( var fileNo in data.body.file__common__attachment) {
						var file = data.body.file__common__attachment[fileNo];

						if (file.fileExtTypeCode == 'video') {
							var html = '<video controls src="/file/streamVideo?id=' + file.id + '&updateDate=' + file.updateDate + '">video not supported</video>';
							$('.reply-list-box tbody > tr[data-id="' + id + '"] [data-file-no="' + fileNo + '"].video-box').append(html);
						} else {
							var html = '<img src="/file/img?id=' + file.id + '&updateDate=' + file.updateDate + '">';
							$('.reply-list-box tbody > tr[data-id="' + id + '"] [data-file-no="' + fileNo + '"].img-box').append(html);
						}
					}
				}
			}

			if (data.msg) {
				alert(data.msg);
			}

			ReplyList__hideModifyFormModal();
			ReplyList__submitModifyFormDone = true;
		};

		startUploadFiles();
	}

	function ReplyList__showModifyFormModal(el) {
		$('html').addClass('reply-modify-form-modal-actived');
		var $tr = $(el).closest('tr');
		var originBody = $tr.data('data-originBody');

		var id = $tr.attr('data-id');

		var form = $('.reply-modify-form-modal form').get(0);

		$(form).find('[data-name]').each(function(index, el) {
			var $el = $(el);

			var name = $el.attr('data-name');
			name = name.replaceAll('__0__', '__' + id + '__');
			$el.attr('name', name);

			if ($el.prop('type') == 'file') {
				$el.val('');
			} else if ($el.prop('type') == 'checkbox') {
				$el.prop('checked', false);
			}
		});

		for (var fileNo = 1; fileNo <= 3; fileNo++) {
			$('.reply-modify-form-modal .video-box-file-' + fileNo).empty();

			var videoName = 'reply__' + id + '__common__attachment__' + fileNo;

			var $videoBox = $('.reply-list-box [data-video-name="' + videoName + '"]');

			if ($videoBox.length > 0) {
				$('.reply-modify-form-modal .video-box-file-' + fileNo).append($videoBox.html());
			}

			$('.reply-modify-form-modal .img-box-file-' + fileNo).empty();

			var imgName = 'reply__' + id + '__common__attachment__' + fileNo;

			var $imgBox = $('.reply-list-box [data-img-name="' + imgName + '"]');

			if ($imgBox.length > 0) {
				$('.reply-modify-form-modal .img-box-file-' + fileNo).append($imgBox.html());
			}
		}

		form.id.value = id;
		form.body.value = originBody;
	}

	function ReplyList__hideModifyFormModal() {
		$('html').removeClass('reply-modify-form-modal-actived');
	}

	// 1초
	ReplyList__loadMoreInterval = 1 * 1000;

	function ReplyList__loadMoreCallback(data) {
		if (data.body.replies && data.body.replies.length > 0) {
			ReplyList__lastLodedId = data.body.replies[data.body.replies.length - 1].id;
			ReplyList__drawReplies(data.body.replies);
		}

		setTimeout(ReplyList__loadMore, ReplyList__loadMoreInterval);
	}

	function ReplyList__loadMore() {

		$.get('../reply/getForPrintReplies', {
			articleId : ${article.id},
			from : ReplyList__lastLodedId + 1
		}, ReplyList__loadMoreCallback, 'json');
	}

	function ReplyList__drawReplies(replies) {
		for (var i = 0; i < replies.length; i++) {
			var reply = replies[i];
			ReplyList__drawReply(reply);
		}
	}

	var ReplyList__delete = false;

	function ReplyList__delete(el) {
	    if (ReplyList__delete) {
            alert('처리중입니다.');
        }
		
		if (confirm('삭제 하시겠습니까?') == false) {
			return;
		}

		var $tr = $(el).closest('tr');

		var id = $tr.attr('data-id');

		$.post('./../reply/doDeleteReplyAjax', {
			id : id
		}, function(data) {
		    if ( data.msg ) {
                alert(data.msg);
            }

			if ( data.resultCode.substr(0, 2) == 'S-' ) {
				$tr.remove();
			}

			ReplyList__delete = true;
		}, 'json');
	}

	function ReplyList__getMediaHtml(reply) {
		var html = '';
		for (var fileNo = 1; fileNo <= 3; fileNo++) {
            var file = null;
            if (reply.extra.file__common__attachment && reply.extra.file__common__attachment[fileNo]) {
                file = reply.extra.file__common__attachment[fileNo];
            }

            html += '<div class="video-box" data-video-name="reply__' + reply.id + '__common__attachment__' + fileNo + '" data-file-no="' + fileNo + '">';

            if (file && file.fileExtTypeCode == 'video') {
                html += '<video controls src="/file/streamVideo?id=' + file.id + '&updateDate=' + file.updateDate + '"></video>';
            }

            html += '</div>';

            html += '<div class="img-box" data-img-name="reply__' + reply.id + '__common__attachment__' + fileNo + '" data-file-no="' + fileNo + '">';

            if (file && file.fileExtTypeCode == 'img') {
                html += '<img src="/file/img?id=' + file.id + '&updateDate=' + file.updateDate + '">';
            }

            html += '</div>';
        }

        return '<div class="media-box">' + html + "</div>";
	}

	function ReplyList__drawReply(reply) {
		var html = '';
		html += '<div class="reply-content" data-id="' + reply.id + '">';
		html += '<div class="reply-etc-box">';
		html += '<div class="reply-writer">[ ' + reply.extra.writer + ' ]</div>';
		html += '<div class="reply-regdate">( ' + reply.regDate + ' )</div>';
		html += '</div>';
		html += '<div class="reply-body-box">';
		html += '<div class="reply-body">' + reply.forPrintBody + '</div>';

		html += ReplyList__getMediaHtml(reply);

		html += '</div>';
		
		html += '<div class="button-box">';
		if (reply.extra.actorCanDelete) {
			html += '<button class="reply-delbtn" type="button" onclick="ReplyList__delete(this);">삭제</button>';
		}

		if (reply.extra.actorCanModify) {
			html += '<button class="reply-modibtn" type="button" onclick="ReplyList__showModifyFormModal(this);">수정</button>';
		}
		html += '</div>';
		html += '</div>';

        

        var $tr = $(html);
        $tr.data('data-originBody', reply.body);
        ReplyList__$tbody.prepend($tr);
    }

    ReplyList__loadMore();
</script>

<%@ include file="../part/foot.jspf"%>