user = User.create!(email: 'user1@example.com', password: 'password')

30.times do |i|
  AnnotationGuideline.create!(
    user_id: user.id,
    title: "Guideline#{i + 1}",
    body: <<~MD
      # Guideline#{i + 1}

      ## Summary
      Guideline#{i + 1} description. Annotate according to this guideline.

      ## Rules
      - **Rule1**: ・・・・・
      - **Rule2**: ・・・・・
      - **Rule3**: ・・・・・

      ## Example
      ```
      curl -X POST /annotation.json
      ```
    MD
  )
end
