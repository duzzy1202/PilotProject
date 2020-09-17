package com.ljh.footballaround.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ljh.footballaround.dto.Article;
import com.ljh.footballaround.dto.Board;

@Mapper
public interface ArticleDao {
	List<Article> getForPrintArticles(int boardId);

	Article getForPrintArticleById(@Param("id") int id);
	
	Article getArticleById(@Param("id") int id);

	void write(Map<String, Object> param);

	void modify(Map<String, Object> param);

	Board getBoardByCode(String boardCode);

	Board getBoardByLeagueId(int leagueId);

	void deleteArticleById(int id);

	List<Article> getArticlesByMemberId(int memberId);

	Article getLastestNotice();

	void updateHitOfArticle(int id, int hits);
}
