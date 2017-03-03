package com.github.todo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.github.todo.vo.Tag;

@Mapper
public interface TagMapper {
	public List<Tag> getTagListByUserId(String userId);

	public Tag getTagById(Integer id);

	public int createTag(Tag tag);

	public int deleteTag(Integer id);

	public int updateTag(Tag tag);
}
